//
//  SettingsAPI.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 16.12.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import Foundation

struct Settings {
    var snoozeTime: Int?
    var fallAsleepTime: Int
    var ringtone: Ringtone
    var isVibrated: Bool
    var alarmVolume: Double
}

struct Ringtone {
    var artistName: String?
    var ringtoneName: String?
    var persistentId: String?
}

