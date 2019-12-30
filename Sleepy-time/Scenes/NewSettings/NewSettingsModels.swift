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
                case updateSettings(settings: SettingsViewModel)
            }
        }
        struct Response {
            enum ResponseType {
                case presentSettings(settings: Settings?)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displaySettings(viewModel: SettingsViewModel)
            }
        }
    }
}

struct SettingsViewModel {
    var snoozeTime: Int?
    var fallAsleepTime: Float
    var ringtone: Ringtone
    var isVibrated: Bool
    var alarmVolume: Float
    
    struct Ringtone {
        var artistName: String
        var ringtoneName: String
        var persistentId: String
    }
}
