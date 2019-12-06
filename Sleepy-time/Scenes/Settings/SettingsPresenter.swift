//
//  SettingsPresenter.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 26.11.2019.
//  Copyright (c) 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol SettingsPresentationLogic {
    func presentData(response: Settings.Model.Response.ResponseType)
}

class SettingsPresenter: SettingsPresentationLogic {
    
    weak var viewController: SettingsDisplayLogic?
    
    func presentData(response: Settings.Model.Response.ResponseType) {
        switch response {
        case .presentSettings:
            let snoozeItem = SettingsSnoozeItem()
            let fallAlseepItem = SettingsFallAlseepItem()
            let songItem = SettingsSongItem()
            let soundValueItem = SettingsSoundValueItem()
            
            let settingsViewModel = SettingsViewModel(items: [snoozeItem,
                                                              fallAlseepItem,
                                                              songItem,
                                                              soundValueItem])
            viewController?.displayData(viewModel: .displaySettings(viewModel: settingsViewModel))
        @unknown default:
            print("SettingsPresenter has another response")
        }
    }
    
}
