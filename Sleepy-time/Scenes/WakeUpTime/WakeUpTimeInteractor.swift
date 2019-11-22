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
    //var name: String { get set }
    var sleepyTime: SleepyTime! { get set }
    var choosenTime: Date! { get set }
    var alarmTimeType: AlarmTimeType! { get set }
}

class WakeUpTimeInteractor: WakeUpTimeBusinessLogic, WakeUpTimeDataStore {
    
    var sleepyTime: SleepyTime!
    var choosenTime: Date!
    var alarmTimeType: AlarmTimeType!
    
    var presenter: WakeUpTimePresentationLogic?
    var worker: WakeUpTimeWorker?
    
    func makeRequest(request: WakeUpTime.Model.Request.RequestType) {
        if worker == nil {
            worker = WakeUpTimeWorker()
        }
        
        switch request {
        case .getWakeUpTime:
            presenter?.presentData(response: .presentWakeUpTime(date: choosenTime, alarmTimeType: alarmTimeType))
//            presenter?.presentData(response: .presentWakeUpTime(viewModel: sleepyTime))
        @unknown default:
            print("WakeUpTimeInteractor has another request")
        }
    }
}
