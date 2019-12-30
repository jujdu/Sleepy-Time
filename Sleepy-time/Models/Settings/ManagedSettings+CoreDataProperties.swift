//
//  ManagedSettings+CoreDataProperties.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 30.12.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//
//

import Foundation
import CoreData


extension ManagedSettings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedSettings> {
        return NSFetchRequest<ManagedSettings>(entityName: "ManagedSettings")
    }

    @NSManaged public var alarmVolume: NSNumber?
    @NSManaged public var fallAsleepTime: NSNumber?
    @NSManaged public var managedRingtone: ManagedRingtone?
    @NSManaged public var isVibrated: NSNumber?
    @NSManaged public var snoozeTime: NSNumber?

}
