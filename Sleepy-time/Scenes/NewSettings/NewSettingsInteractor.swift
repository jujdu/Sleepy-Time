//
//  NewSettingsInteractor.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 13.12.2019.
//  Copyright (c) 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol NewSettingsBusinessLogic {
    func makeRequest(request: NewSettings.Model.Request.RequestType)
    var settings: Settings? { get set }
}

protocol NewSettingsDataStore {
    var settings: Settings? { get set }
}

class NewSettingsInteractor: NewSettingsBusinessLogic, NewSettingsDataStore {
    
    var presenter: NewSettingsPresentationLogic?
    var worker: NewSettingsWorker?
    var settings: Settings?
    
    func makeRequest(request: NewSettings.Model.Request.RequestType) {
        if worker == nil {
            worker = NewSettingsWorker()
        }
        
        switch request {
        case .getSettings:
            worker?.fetchSettings { (settings) in
                self.settings = settings
                self.presenter?.presentData(response: .presentSettings(settings: settings))
            }
        case .updateSettings(let settings):
            worker?.updateSettings(settingsToUpdate: settings, completionHandler: { (settings) in
                self.settings = settings
            })
        @unknown default:
            print("SettingsInteractor has another response")
        }
    }
    
}
