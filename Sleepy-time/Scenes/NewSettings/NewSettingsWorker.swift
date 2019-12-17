//
//  NewSettingsWorker.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 13.12.2019.
//  Copyright (c) 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class NewSettingsWorker {
    
    var settingsStore: CoreDataStackStoreProtocol
    
    init(settingsStore: CoreDataStackStoreProtocol = CoreDataStack()) {
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
        settingsStore.updateSettings(settingsToUpdate: settingsToUpdate) { settings in
            DispatchQueue.main.async {
                guard let settings = settings else {
                    completionHandler(nil)
                    return }
                completionHandler(settings)
            }
        }
    }
}
