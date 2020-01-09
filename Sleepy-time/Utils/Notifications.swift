//
//  Notifications.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 09.01.2020.
//  Copyright © 2020 Michael Sidoruk. All rights reserved.
//

import UIKit
import UserNotifications

class Notifications: NSObject {
    
    let notificationCenter = UNUserNotificationCenter.current()
    weak var viewController: UIViewController?
    
    //ask user if we can push notifications to him
    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert,.badge,.sound]) { (granted, error) in
            print("Permission granted: \(granted)")
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    //get NotificationSettings from settings
    func getNotificationSettings() {
        notificationCenter.getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
        }
    }
    
    //set timer for notifications
    func scheduleNotification(viewController: UIViewController? = nil) {
        
        self.viewController = viewController
        
        let content = UNMutableNotificationContent()
        let requestIdentifire = "LocalNotification"
        let userActionIdentifire = "UserActionIdentifire"
        
        //content setup
        content.title = "Alarm"
        content.title = "It's time to wake up, body!"
        content.sound = UNNotificationSound.default
        content.badge = 1
        content.categoryIdentifier = userActionIdentifire
        
        //date and trigger setup
        let date = Date(timeIntervalSinceNow: 5)
        let dateMatching = Calendar.current.dateComponents([.day,.hour,.minute,.second], from: date)
        print(dateMatching)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateMatching, repeats: false)
        
        //request setup
        let request = UNNotificationRequest(identifier: requestIdentifire, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                debugPrint("Error \(error.localizedDescription)")
            }
        }
        
        //category setup
        let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
        let stopAction = UNNotificationAction(identifier: "Stop", title: "Stop", options: [.destructive])
        
        let category = UNNotificationCategory(identifier: userActionIdentifire,
                                              actions: [snoozeAction,stopAction],
                                              intentIdentifiers: [],
                                              options: [])
        notificationCenter.setNotificationCategories([category])
        
        print(#function)
    }
    
}


//MARK: - UNUserNotificationCenterDelegate
extension Notifications: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "LocalNotification" {
            print("Handling notification")
        }
        
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("dissmiss action")
        case UNNotificationDefaultActionIdentifier://when tap on notification
            print("default action")
            viewController?.present(UIViewController(), animated: true, completion: nil)
        case "Snooze":
            print("Snooze action")
            self.scheduleNotification()
        case "Stop":
            print("Stop action")
        default:
            print("unknown action")
        }
        
        completionHandler()
    }
}
