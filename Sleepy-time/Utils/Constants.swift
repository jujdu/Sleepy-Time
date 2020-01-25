//
//  Constants.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 09/09/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

struct UserDefaultKeys {
    static let repeatLbl = "repeatLbl"
}

struct UNNotificationKeys {
    
    struct Identifiers {
        static let request = "LocalNotification"
        static let category = "CategoryIdentifier"
        
        struct Actions {
            static let snooze = "Snooze"
            static let stop = "Stop"
        }
    }
}

struct AppFonts {
    static let avenirLight = "Avenir-Light"
    static let avenirBook = "Avenir-Book"
    static let avenirHeavy = "Avenir-Heavy"
}

struct AppImages {
    static let addAlarm = "AddAlarm"
    static let addAlarm36pt = "AddAlarm36pt"
    static let settings = "Settings"
    static let info = "Info"
    static let pause = "pause.fill"
    static let play = "play.fill"
}

struct Constraints {
    static let cellPaddings = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    static let buttonPaddings = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    static let buttonHeight: CGFloat = 43.0
}
