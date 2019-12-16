//
//  OldSettingsInteractor.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 26.11.2019.
//  Copyright (c) 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol OldSettingsBusinessLogic {
    func makeRequest(request: OldSettings.Model.Request.RequestType)
}

protocol OldSettingsDataStore {
    //var name: String { get set }
}

class OldSettingsInteractor: OldSettingsBusinessLogic, OldSettingsDataStore {
    
    var presenter: OldSettingsPresentationLogic?
    var worker: OldSettingsWorker?

    func makeRequest(request: OldSettings.Model.Request.RequestType) {
        if worker == nil {
            worker = OldSettingsWorker()
        }
        
        switch request {
        case .getSettings(let settings):
            presenter?.presentData(response: .presentSettings(settings: settings))
        @unknown default:
            print("SettingsInteractor has another response")
        }
    }
}
