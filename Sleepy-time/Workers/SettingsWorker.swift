//
//  SettingsWorker.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 16.12.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import Foundation

class SettingsWorker {
    
    var settingsStore: CoreDataStack
    
    init(settingsStore: CoreDataStack = CoreDataStack()) {
        self.settingsStore = settingsStore
    }
    
    func fetchSettings(completionHandler: @escaping (Settings?) -> ()) {
        settingsStore.fetchSettings { settings in
            DispatchQueue.main.async {
                guard let settings = settings else {
                    completionHandler(nil)
                    return }
                completionHandler(settings)
            }
        }
    }
    
    func updateSettings(settingsToUpdate: Settings, completionHandler: @escaping (Settings?) -> ()) {
        settingsStore.updateSettings(settingsToUpdate: settingsToUpdate) { (settings) in
            DispatchQueue.main.async {
                guard let settings = settings else {
                    completionHandler(nil)
                    return }
                completionHandler(settings)
            }
        }
    }
    
}
