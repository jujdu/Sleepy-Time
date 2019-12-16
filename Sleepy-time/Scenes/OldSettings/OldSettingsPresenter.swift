//
//  OldSettingsPresenter.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 26.11.2019.
//  Copyright (c) 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol OldSettingsPresentationLogic {
    func presentData(response: OldSettings.Model.Response.ResponseType)
}

class OldSettingsPresenter: OldSettingsPresentationLogic {
    
    weak var viewController: OldSettingsDisplayLogic?
    
    func presentData(response: OldSettings.Model.Response.ResponseType) {
        switch response {
        case .presentSettings(let settings): break
            
//            var items = [SettingsItemProtocol]()
//            items.append(SettingsSnoozeItem())
//            items.append(SettingsFallAlseepItem(value: Double(settings.fallAsleepTime)))
//            items.append(SettingsSongItem())
//            items.append(SettingsSoundVibrationItem(value: settings.isVibrated))
//            items.append(SettingsSoundValueItem(volume: Double(settings.alarmVolume)))
            
//            let settingsViewModel = SettingsViewModel(items: items)
//            viewController?.displayData(viewModel: .displaySettings(viewModel: settingsViewModel))
        @unknown default:
            print("SettingsPresenter has another response")
        }
    }
    
}
