//
//  CoreDataStack.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 10.12.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Sleepy-time")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    var settingsObject: ManagedSettings!
    
    func fetchSettings(completionHandler: @escaping (Settings?) -> ()) {
        persistentContainer.viewContext.perform {
            do {
                let fetchRequest: NSFetchRequest<ManagedSettings> = ManagedSettings.fetchRequest()
                fetchRequest.returnsObjectsAsFaults = false
                
                var settings: Settings
                
                let results = try self.persistentContainer.viewContext.fetch(fetchRequest)
                if results.isEmpty {
                    self.settingsObject = ManagedSettings(context: self.persistentContainer.viewContext)
                    self.settingsObject.snoozeTime = 5
                    self.settingsObject.fallAsleepTime = 14
                    self.settingsObject.ringtone = Data()
                    self.settingsObject.isVibrated = true
                    self.settingsObject.alarmVolume = 1
                    try self.persistentContainer.viewContext.save()
                    settings = self.settingsObject.toSettings()
                    completionHandler(settings)
                } else {
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
    
    func updateSettings(settingsToUpdate: Settings, completionHandler: @escaping (Settings?) -> ()) {
        persistentContainer.viewContext.perform {
            do {
                let fetchRequest: NSFetchRequest<ManagedSettings> = ManagedSettings.fetchRequest()
                fetchRequest.returnsObjectsAsFaults = false
                self.settingsObject.fromSettings(settings: settingsToUpdate)
                do {
                    try self.persistentContainer.viewContext.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
