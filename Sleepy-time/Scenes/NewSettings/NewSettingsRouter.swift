//
//  NewSettingsRouter.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 13.12.2019.
//  Copyright (c) 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol NewSettingsRoutingLogic {
    func routeToMain()
}

protocol NewSettingsDataPassing {
    var dataStore: NewSettingsDataStore? { get }
}

class NewSettingsRouter: NSObject, NewSettingsRoutingLogic, NewSettingsDataPassing {
    
    weak var viewController: NewSettingsViewController?
    var dataStore: NewSettingsDataStore?
    
    // MARK: - Routing

    func routeToMain() {
        let destinationVC = MainViewController()
        navigateToMain(source: viewController!, destination: destinationVC)
    }
    
    
    // MARK: - Navigation
    
    func navigateToMain(source: NewSettingsViewController, destination: MainViewController) {
        source.avWorker.stopRingtone()
        source.avWorker.mpVolumeView.setVolume(source.avWorker.userVolumeValue)
        source.dismiss(animated: true, completion: nil)
    }
    
}
