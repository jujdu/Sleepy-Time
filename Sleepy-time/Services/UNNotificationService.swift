//
//  UNNotificationService.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 09.01.2020.
//  Copyright © 2020 Michael Sidoruk. All rights reserved.
//

import UIKit
import UserNotifications

class UNNotificationService: NSObject {
    
    let notificationCenter = UNUserNotificationCenter.current()
    var avWorker = AVAudioEngineWorker.shared
    
    var settings: Settings?
    
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
    func scheduleNotification(atDate: Date, withSettings settings: Settings?) {
        
        //calculate time interval
        let atDate = Date() + 15
        
        let timeInterval = atDate.timeIntervalSince(Date())
        print("Caclulated timeInterval \(timeInterval)")
        
        let content = UNMutableNotificationContent()
        //content setup
        content.title = "Alarm"
        content.title = "It's time to wake up, body!"
        content.sound = UNNotificationSound.default
        content.badge = 1
        content.categoryIdentifier = UNNotificationKeys.Identifiers.category
        
        //trigger setup
        let dateMatching = Calendar.current.dateComponents([.day,.hour,.minute,.second], from: atDate)
        print(dateMatching)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateMatching, repeats: false)
        
        //request setup
        let request = UNNotificationRequest(identifier: UNNotificationKeys.Identifiers.request,
                                            content: content,
                                            trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                debugPrint("Error \(error.localizedDescription)")
            }
        }
        
        //category setup
        let snoozeAction = UNNotificationAction(identifier: UNNotificationKeys.Identifiers.Actions.snooze,
                                                title: UNNotificationKeys.Identifiers.Actions.snooze,
                                                options: [])
        let stopAction = UNNotificationAction(identifier: UNNotificationKeys.Identifiers.Actions.stop,
                                              title: UNNotificationKeys.Identifiers.Actions.stop,
                                              options: [.destructive])
        
        let category = UNNotificationCategory(identifier: UNNotificationKeys.Identifiers.category,
                                              actions: [snoozeAction,stopAction],
                                              intentIdentifiers: [],
                                              options: [])
        notificationCenter.setNotificationCategories([category])
        
        print(#function)

        self.settings = settings
        AVAudioEngineWorker.shared.startRingtone(atTime: timeInterval, settings: settings)
    }
    
    private func snoozeScheduleNotification() {
        guard let settings = settings, let snoozeTime = settings.snoozeTime else { return }
        let date = Date() + Double(snoozeTime)
        self.scheduleNotification(atDate: date, withSettings: settings)
    }
}

//MARK: - UNUserNotificationCenterDelegate
extension UNNotificationService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        self.showAlarmViewController()
        completionHandler([.alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.notification.request.identifier == UNNotificationKeys.Identifiers.request {
            print("Handling notification")
        }
        
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("dissmiss action")
        case UNNotificationDefaultActionIdentifier://when tap on notification
            print("default action")
            let state = UIApplication.shared.applicationState
            if state == .inactive || state == .background {
                self.showAlarmViewController()
            } else if state == .active {
                print("active")
            }
            
        case UNNotificationKeys.Identifiers.Actions.snooze:
            print("Snooze action")
            self.avWorker.stopRingtone()
            
//            self.scheduleNotification(atDate: Date() + 10)
            self.snoozeScheduleNotification()
        case UNNotificationKeys.Identifiers.Actions.stop:
            print("Stop action")
            self.avWorker.stopRingtone()
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


//let window = (UIApplication.shared.delegate as? AppDelegate)?.window
//let navVC = (window?.rootViewController as? UINavigationController)
//let mainVC = navVC?.viewControllers.first
//
//if !(mainVC?.presentedViewController is AlarmViewController) {
//}
