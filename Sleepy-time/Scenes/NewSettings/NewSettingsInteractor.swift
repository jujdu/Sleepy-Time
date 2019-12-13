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
}

protocol NewSettingsDataStore {
    //var name: String { get set }
}

class NewSettingsInteractor: NewSettingsBusinessLogic, NewSettingsDataStore {
    
    var presenter: NewSettingsPresentationLogic?
    var worker: NewSettingsWorker?
    
    func makeRequest(request: NewSettings.Model.Request.RequestType) {
        if worker == nil {
            worker = NewSettingsWorker()
        }
        
        switch request {
        case .getSettings(let settings):
            presenter?.presentData(response: .presentSettings(settings: settings))
        @unknown default:
            print("SettingsInteractor has another response")
        }
    }
    
}
