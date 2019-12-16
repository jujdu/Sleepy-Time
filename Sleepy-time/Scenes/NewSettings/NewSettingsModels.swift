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
                case getSettings
                case updateSettings(settings: Settings)
            }
        }
        struct Response {
            enum ResponseType {
                case presentSettings(settings: Settings?)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displaySettings(viewModel: Settings)
            }
        }
    }
    
    struct SettingsToUpdate {
        var alarmVolume: Float
        var fallAsleepTime: Float
        var isVibrated: Bool
        var ringtone: Data
        var snoozeTime: Int
    }
}
