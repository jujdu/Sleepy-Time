//
//  ManagedRingtone+CoreDataProperties.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 30.12.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//
//

import Foundation
import CoreData


extension ManagedRingtone {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedRingtone> {
        return NSFetchRequest<ManagedRingtone>(entityName: "ManagedRingtone")
    }

    @NSManaged public var artistName: String?
    @NSManaged public var persistentId: String?
    @NSManaged public var ringtoneName: String?
    @NSManaged public var managedSettings: ManagedSettings?

}
