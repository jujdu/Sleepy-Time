//
//  SettingsInteractor.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 26.11.2019.
//  Copyright (c) 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol SettingsBusinessLogic {
    func makeRequest(request: Settings.Model.Request.RequestType)
}

protocol SettingsDataStore {
    //var name: String { get set }
}

class SettingsInteractor: SettingsBusinessLogic, SettingsDataStore {
    
    var presenter: SettingsPresentationLogic?
    var worker: SettingsWorker?
    
    func makeRequest(request: Settings.Model.Request.RequestType) {
        if worker == nil {
            worker = SettingsWorker()
        }
    }
    
}
