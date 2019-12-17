//
//  Settings.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 16.12.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import Foundation

struct Settings {
    var snoozeTime: Int?
    var fallAsleepTime: Int
    var ringtone: Data?
    var isVibrated: Bool
    var alarmVolume: Double
}
