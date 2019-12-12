//
//  SettingsDataBase+CoreDataProperties.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 10.12.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//
//

import Foundation
import CoreData


extension SettingsDataBase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SettingsDataBase> {
        return NSFetchRequest<SettingsDataBase>(entityName: "SettingsDataBase")
    }

    @NSManaged public var snoozeTime: Int16
    @NSManaged public var fallAsleepTime: Int16
    @NSManaged public var ringtone: Data?
    @NSManaged public var isVibrated: Bool
    @NSManaged public var alarmVolume: Float

}
