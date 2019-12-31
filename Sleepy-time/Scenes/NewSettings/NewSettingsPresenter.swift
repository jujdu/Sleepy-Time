//
//  NewSettingsPresenter.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 13.12.2019.
//  Copyright (c) 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol NewSettingsPresentationLogic {
    func presentData(response: NewSettings.Model.Response.ResponseType)
}

class NewSettingsPresenter: NewSettingsPresentationLogic {
    
    weak var viewController: NewSettingsDisplayLogic?
    
    func presentData(response: NewSettings.Model.Response.ResponseType) {
        switch response {
        case .presentSettings(let settings):
            guard let settings = settings else { return }
            let viewModel = fromSettingsToViewModel(settings: settings)
            viewController?.displayData(viewModel: .displaySettings(viewModel: viewModel))
        @unknown default:
            print("SettingsPresenter has another response")
        }
    }
    
    private func fromSettingsToViewModel(settings: Settings) -> SettingsViewModel {
        return SettingsViewModel(snoozeTime: settings.snoozeTime,
                                 fallAsleepTime: Float(settings.fallAsleepTime),
                                 ringtone: SettingsViewModel.Ringtone(artistName: settings.ringtone.artistName,
                                                                      ringtoneName: settings.ringtone.ringtoneName,
                                                                      persistentId: settings.ringtone.persistentId ?? ""),
                                 isVibrated: settings.isVibrated,
                                 alarmVolume: Float(settings.alarmVolume))
    }
}
