//
//  SettingsDataBase+CoreDataProperties.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 13.12.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//
//

import Foundation
import CoreData


extension SettingsDataBase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SettingsDataBase> {
        return NSFetchRequest<SettingsDataBase>(entityName: "SettingsDataBase")
    }

    @NSManaged public var alarmVolume: NSNumber?
    @NSManaged public var fallAsleepTime: NSNumber?
    @NSManaged public var isVibrated: NSNumber?
    @NSManaged public var ringtone: Data?
    @NSManaged public var snoozeTime: NSNumber?

}
