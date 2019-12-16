//
//  MainRouter.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 22.11.2019.
//  Copyright (c) 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol MainRoutingLogic {
    func routeToWakeUpTime()
//    func routeToSettings()
    func routeToNewSettings()
}

protocol MainDataPassing {
    var dataStore: MainDataStore? { get }
}

class MainRouter: NSObject, MainRoutingLogic, MainDataPassing {
    
    weak var viewController: MainViewController?
    var dataStore: MainDataStore?
    
    // MARK: - Routing
    func routeToWakeUpTime() {
        let destinationVC = WakeUpTimeViewController()
        var destinationDS = destinationVC.router!.dataStore!
        navigateToWakeUpTime(source: viewController!, destination: destinationVC)
        passDataToWakeUpTime(source: dataStore!, destination: &destinationDS)
    }
    
//    func routeToSettings() {
//        let destinationVC = SettingsViewController()
//        let navVC = UINavigationController(rootViewController: destinationVC)
//        navigateToSettings(source: viewController!, destination: navVC)
//    }
    
    func routeToNewSettings() {
        let sb = UIStoryboard(name: "Settings", bundle: nil)
        let destinationVC = sb.instantiateViewController(withIdentifier: "NewSettingsViewController") as! NewSettingsViewController
        let navVC = UINavigationController(rootViewController: destinationVC)
        navigateToNewSettings(source: viewController!, destination: navVC)
    }
    
    // MARK: - Navigation
    func navigateToWakeUpTime(source: MainViewController, destination: WakeUpTimeViewController) {
        source.show(destination, sender: nil)
    }
    
    func navigateToSettings(source: MainViewController, destination: UINavigationController) {
        destination.modalPresentationStyle = .fullScreen
        source.present(destination, animated: true, completion: nil)
    }
    
    func navigateToNewSettings(source: MainViewController, destination: UINavigationController) {
        destination.modalPresentationStyle = .fullScreen
        source.present(destination, animated: true, completion: nil)
    }
    
    // MARK: - Passing data
    func passDataToWakeUpTime(source: MainDataStore, destination: inout WakeUpTimeDataStore) {
        destination.sleepyTime = source.sleepyTime
    }
}
