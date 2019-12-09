//
//  MainInteractor.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 22.11.2019.
//  Copyright (c) 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol MainBusinessLogic {
    func makeRequest(request: Main.Model.Request.RequestType)
}

protocol MainDataStore {
    var sleepyTime: SleepyTime! { get set }
}

class MainInteractor: MainBusinessLogic, MainDataStore {
    
    var sleepyTime: SleepyTime!
    
    var presenter: MainPresentationLogic?
    var worker: MainWorker?
    
    func makeRequest(request: Main.Model.Request.RequestType) {
        if worker == nil {
            worker = MainWorker()
        }
        
        switch request {
        case .setWakeUpTime(let sleepyTime):
            self.sleepyTime = sleepyTime
        }
    }
    
}
