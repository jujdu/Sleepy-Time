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
    var worker = SettingsWorker()
    var settings: Settings?
    
    func makeRequest(request: NewSettings.Model.Request.RequestType) {
        switch request {
        case .getSettings:
            worker.fetchSettings { (settings) in
                self.settings = settings
                self.presenter?.presentData(response: .presentSettings(settings: settings))
            }
        case .updateSettings(let settingsViewModel):
            let settings = settingsFromSettingsViewModel(settingsViewModel)
            worker.updateSettings(settingsToUpdate: settings, completionHandler: { (settings) in
                self.settings = settings
            })
        }
    }
    
    private func settingsFromSettingsViewModel(_ settingsViewModel: SettingsViewModel) -> Settings {
        return Settings(snoozeTime: settingsViewModel.snoozeTime,
                        fallAsleepTime: Int(settingsViewModel.fallAsleepTime),
                        ringtone: Ringtone(artistName: settingsViewModel.ringtone.artistName,
                                           ringtoneName: settingsViewModel.ringtone.ringtoneName,
                                           persistentId: settingsViewModel.ringtone.persistentId),
                        isVibrated: settingsViewModel.isVibrated,
                        alarmVolume: Double(settingsViewModel.alarmVolume))
    }
}
