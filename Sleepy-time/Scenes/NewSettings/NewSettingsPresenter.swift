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
            viewController?.displayData(viewModel: .displaySettings(viewModel: settings))
        @unknown default:
            print("SettingsPresenter has another response")
        }
    }
    
}
