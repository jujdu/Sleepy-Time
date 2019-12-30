//
//  CoreDataStack.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 10.12.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import Foundation
import CoreData


protocol CoreDataStackStoreProtocol {
    func fetchSettings(completionHandler: @escaping (Settings?) -> ())
    func updateSettings(settingsToUpdate: Settings, completionHandler: @escaping (Settings?) -> ())
}

final class CoreDataStack: CoreDataStackStoreProtocol {
    // MARK: - Core Data stack
    private var settingsObject: ManagedSettings!
    private var ringtoneObject: ManagedRingtone!
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Sleepy-time")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //MARK: - Fetching settings
    func fetchSettings(completionHandler: @escaping (Settings?) -> ()) {
        persistentContainer.viewContext.perform {
            do {
                let fetchRequest: NSFetchRequest<ManagedSettings> = ManagedSettings.fetchRequest()
                fetchRequest.returnsObjectsAsFaults = false
                
                var settings: Settings
                
                let results = try self.persistentContainer.viewContext.fetch(fetchRequest)
                
                if results.isEmpty {
                    //MARK: - Setup default settings
                    self.settingsObject = ManagedSettings(context: self.persistentContainer.viewContext)
                    self.ringtoneObject = ManagedRingtone(context: self.persistentContainer.viewContext)
                    self.ringtoneObject.artistName = " "
                    self.ringtoneObject.ringtoneName = " "
                    self.ringtoneObject.persistentId = " "
                    
                    self.settingsObject.snoozeTime = 5
                    self.settingsObject.fallAsleepTime = 14
                    self.settingsObject.managedRingtone = self.ringtoneObject
                    self.settingsObject.isVibrated = true
                    self.settingsObject.alarmVolume = 1
                    try self.persistentContainer.viewContext.save()
                    settings = self.settingsObject.toSettings()
                    completionHandler(settings)
                } else {
                    //MARK: - Get data from CD
                    self.settingsObject = results.first!
                    settings = self.settingsObject.toSettings()
                    completionHandler(settings)
                }
            } catch {
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }
    }
    
    //MARK: - Updating settings
    func updateSettings(settingsToUpdate: Settings, completionHandler: @escaping (Settings?) -> ()) {
        persistentContainer.viewContext.perform {
            do {
                let fetchRequest: NSFetchRequest<ManagedSettings> = ManagedSettings.fetchRequest()
                fetchRequest.returnsObjectsAsFaults = false
                self.settingsObject.fromSettings(settings: settingsToUpdate)
                do {
                    try self.persistentContainer.viewContext.save()
                    let settings = self.settingsObject.toSettings()
                    completionHandler(settings)
                } catch {
                    completionHandler(nil)
                    print(error.localizedDescription)
                }
            }
        }
    }
}
