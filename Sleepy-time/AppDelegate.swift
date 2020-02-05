//
//  AppDelegate.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 09/09/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit
import AVFoundation
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    lazy var coreDataStack = CoreDataStack()
    let UNNotifications = UNNotificationService()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //MARK: - Windows setup
        window = UIWindow(frame: UIScreen.main.bounds)
        //        let viewController = MainViewController()
        //        let viewController = TryWeatherViewController()
        //        let navigationController = UINavigationController(rootViewController: viewController)
        //        window?.rootViewController = navigationController
        //        window?.makeKeyAndVisible()
        let viewController = MainTabBarController()
//        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        
//        viewController.context = coreDataStack.persistentContainer.viewContext
        
        //MARK: - NC setup
//        navigationController.navigationBar.barStyle = .black
//        navigationController.navigationBar.isTranslucent = true
//        //        navigationController.navigationBar.tintColor = .white
//        navigationController.navigationBar.titleTextAttributes = [
//            NSAttributedString.Key.foregroundColor: UIColor.white,
//            NSAttributedString.Key.font: UIFont(name: AppFonts.avenirHeavy, size: 18)!
//        ]
        
        //MARK: - For not interupting other sounds
        avAudioSessionPlayback()
        
        //MARK: - Notification setup
        UNNotifications.notificationCenter.delegate = UNNotifications
        UNNotifications.requestAuthorization()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        print(#function)
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print(#function)
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        coreDataStack.saveContext()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print(#function)
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print(#function)
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        if AVAudioEngineWorker.shared.isPlaying {
            print("isPlaying")
            let window = (UIApplication.shared.delegate as? AppDelegate)?.window
            let navVC = (window?.rootViewController as? UINavigationController)
            let mainVC = navVC?.viewControllers.first
            navVC?.popToRootViewController(animated: true)
            let alarmVC = AlarmViewController()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                mainVC?.present(alarmVC, animated: true, completion: nil)
            }
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print(#function)
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        coreDataStack.saveContext()
    }
    
  
}

