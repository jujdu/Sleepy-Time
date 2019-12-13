//
//  SettingsDataBase+CoreDataClass.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 13.12.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//
//

import Foundation
import CoreData

@objc(SettingsDataBase)
public class SettingsDataBase: NSManagedObject {

    func toMySettings() -> MySettings {
        return MySettings(alarmVolume: alarmVolume?.intValue ?? 0,
                          fallAsleepTime: fallAsleepTime?.intValue ?? 0,
                          isVibrated: isVibrated?.boolValue ?? true,
                          ringtone: Data(),
                          snoozeTime: snoozeTime?.intValue)
    }
    
    func fromMySettings(mySettings: MySettings) {
        alarmVolume = NSNumber(integerLiteral: mySettings.alarmVolume)
        fallAsleepTime = NSNumber(integerLiteral: mySettings.fallAsleepTime)
        isVibrated = NSNumber(booleanLiteral: mySettings.isVibrated)
        ringtone = mySettings.ringtone
        snoozeTime = mySettings.snoozeTime as NSNumber?
    }
}
