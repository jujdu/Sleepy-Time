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
    static let repeatSlider = "repeatSlider"
    static let repeatSwitch = "repeatSwitch"
    static let fallAsleepSlider = "fallAsleepSlider"
}

struct AppFonts {
    static let avenirLight = "Avenir-Light"
    static let avenirBook = "Avenir-Book"
    static let avenirHeavy = "Avenir-Heavy"
}

struct Constraints {
    static let cellPaddings = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    static let buttonPaddings = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    static let buttonHeight: CGFloat = 40.0
}
