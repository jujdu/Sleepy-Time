//
//  ManagedSettings+CoreDataClass.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 13.12.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ManagedSettings)
public class ManagedSettings: NSManagedObject {
    
    func toSettings() -> Settings {
        return Settings(snoozeTime: snoozeTime?.intValue,
                        fallAsleepTime: fallAsleepTime?.intValue ?? 0,
                        ringtone: managedRingtone?.toRingtone(managedRingtone: managedRingtone) ?? Ringtone(),
                        isVibrated: isVibrated?.boolValue ?? true,
                        alarmVolume: alarmVolume?.doubleValue ?? 0)
    }
    
    func fromSettings(settings: Settings) {
        alarmVolume = NSNumber(value: settings.alarmVolume)
        fallAsleepTime = NSNumber(value: settings.fallAsleepTime)
        isVibrated = NSNumber(value: settings.isVibrated)
        managedRingtone = managedRingtone?.fromRingtone(ringtone: settings.ringtone)
        snoozeTime = settings.snoozeTime as NSNumber?
    }

}
