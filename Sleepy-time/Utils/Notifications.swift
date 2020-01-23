//
//  Notifications.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 09.01.2020.
//  Copyright © 2020 Michael Sidoruk. All rights reserved.
//

import UIKit
import UserNotifications
import MediaPlayer
import CoreHaptics


class Notifications: NSObject {
    
    let notificationCenter = UNUserNotificationCenter.current()
    var avWorker = AVEngineWorker()
    
    //ask user if we can push notifications to him
    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
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
    func scheduleNotification() {
        
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
        let date = Date(timeIntervalSinceNow: 600)
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
        
        let settings = SettingsViewModel.init(snoozeTime: 1, fallAsleepTime: 1, ringtone: SettingsViewModel.Ringtone(artistName: "", ringtoneName: "", persistentId: "1941610159300640504"), isVibrated: true, alarmVolume: 0.2)
        
        //vibrate phone first
        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            //set vibrate callback
            AudioServicesAddSystemSoundCompletion(SystemSoundID(kSystemSoundID_Vibrate),nil, nil, { (_:SystemSoundID, _:UnsafeMutableRawPointer?) -> Void in
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate)) }, nil)
        }
        
        //        avWorker.playRingtone1(true, viewModel: settings)
        avWorker.playRingtone(true, viewModel: settings)
    }
    
}

//MARK: - UNUserNotificationCenterDelegate
extension Notifications: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.badge])
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
            self.showAlarmViewController()
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
    
    private func showAlarmViewController() {
        let window = (UIApplication.shared.delegate as? AppDelegate)?.window
        let navVC = (window?.rootViewController as? UINavigationController)
        let mainVC = navVC?.viewControllers.first
        navVC?.popToRootViewController(animated: true)
        let alarmVC = AlarmViewController()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            mainVC?.present(alarmVC, animated: true, completion: nil)
        }
        //если делать презент без задержки, то будет ошибка "Presenting view controllers on detached view controllers is discouraged". Она вроде не влияет на работу, но на всякий случай делаю задержку, которая убирает ошибку. Через координатор тоже делать не очень, т.к. если нет анимации у транзишена, то комплишен координатора не срабатывает.
    }
}



//Метод willPresent notification не может вызывать работу AVPlayerов, приходится заранее включать плееры и делать отложенный старт...
// //работает, но только через системный плеер
//let mp = MPMusicPlayerController.systemMusicPlayer
//let predicate = MPMediaPropertyPredicate(value: settings.ringtone.persistentId, forProperty: MPMediaItemPropertyPersistentID)
//let query = MPMediaQuery()
//query.addFilterPredicate(predicate)
//guard let items = query.items, items.count > 0 else { return }
//let mPMediaItemCollection = MPMediaItemCollection(items: items)
//mp.setQueue(with: mPMediaItemCollection)
//mp.prepareToPlay()
//mp.play()

//не работает без системного плеера, мб нужно получать токен. Нужен аккаунт разработчика
//upd. из-за того что воркер создавался в методе, после его выполнения, воркер деинициализировался. С сильной ссылкой работает.
//self.avWorker.playRingtone(true, viewModel: settings)




//не работает если animated FALSE
//navVC?.transitionCoordinator?.animate(alongsideTransition: nil) { _ in
//    print("transitionCoordinator")
//    let alarmVC = AlarmViewController()
//    mainVC?.present(alarmVC, animated: true, completion: nil)
//}
