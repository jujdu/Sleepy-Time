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
    
    // MARK: - Navigation
    func navigateToWakeUpTime(source: MainViewController, destination: WakeUpTimeViewController) {
        source.show(destination, sender: nil)
    }
    
    // MARK: - Passing data
    func passDataToWakeUpTime(source: MainDataStore, destination: inout WakeUpTimeDataStore) {
        destination.sleepyTime = source.sleepyTime
        destination.choosenTime = source.choosenTime
        destination.alarmTimeType = source.alarmTimeType
    }
}
