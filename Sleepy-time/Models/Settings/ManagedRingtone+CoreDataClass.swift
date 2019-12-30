//
//  ManagedRingtone+CoreDataClass.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 30.12.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ManagedRingtone)
public class ManagedRingtone: NSManagedObject {

    func toRingtone(managedRingtone: ManagedRingtone?) -> Ringtone {
        return Ringtone(artistName: managedRingtone?.artistName,
                        ringtoneName: managedRingtone?.ringtoneName,
                        persistentId: managedRingtone?.persistentId)
    }
    
    func fromRingtone(ringtone: Ringtone) -> ManagedRingtone? {
        artistName = ringtone.artistName
        ringtoneName = ringtone.ringtoneName
        persistentId = ringtone.persistentId
        return self
    }
}

