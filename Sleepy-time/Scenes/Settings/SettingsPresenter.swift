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
            
            var items = [SettingsItemProtocol]()
            items.append(SettingsSnoozeItem())
            items.append(SettingsFallAlseepItem())
            items.append(SettingsSongItem())
            items.append(SettingsSoundVibrationItem())
            items.append(SettingsSoundValueItem())
            
            let settingsViewModel = SettingsViewModel(items: items)
            viewController?.displayData(viewModel: .displaySettings(viewModel: settingsViewModel))
        @unknown default:
            print("SettingsPresenter has another response")
        }
    }
    
}
