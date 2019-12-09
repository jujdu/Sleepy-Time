//
//  WakeUpTimeInteractor.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 22.11.2019.
//  Copyright (c) 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol WakeUpTimeBusinessLogic {
    func makeRequest(request: WakeUpTime.Model.Request.RequestType)
}

protocol WakeUpTimeDataStore {
    var sleepyTime: SleepyTime! { get set }
}

class WakeUpTimeInteractor: WakeUpTimeBusinessLogic, WakeUpTimeDataStore {
    
    var sleepyTime: SleepyTime!
    
    var presenter: WakeUpTimePresentationLogic?
    var worker: WakeUpTimeWorker?
    
    func makeRequest(request: WakeUpTime.Model.Request.RequestType) {
        if worker == nil {
            worker = WakeUpTimeWorker()
        }
        
        switch request {
        case .getWakeUpTime:
            presenter?.presentData(response: .presentWakeUpTime(sleepyTime: sleepyTime))
        @unknown default:
            print("WakeUpTimeInteractor has another request")
        }
    }
}
