//
//  NewSettingsModels.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 13.12.2019.
//  Copyright (c) 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

enum NewSettings {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getSettings(settings: SettingsDataBase)
            }
        }
        struct Response {
            enum ResponseType {
                case presentSettings(settings: SettingsDataBase)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displaySettings(viewModel: SettingsDataBase)
            }
        }
    }
    
}