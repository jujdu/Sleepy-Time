//
//  WakeUpTimePresenter.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 22.11.2019.
//  Copyright (c) 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol WakeUpTimePresentationLogic {
    func presentData(response: WakeUpTime.Model.Response.ResponseType)
}

class WakeUpTimePresenter: WakeUpTimePresentationLogic {
    
    weak var viewController: WakeUpTimeDisplayLogic?
    
    func presentData(response: WakeUpTime.Model.Response.ResponseType) {
        switch response {
        case .presentWakeUpTime(let sleepyTime):
            let date = sleepyTime.choosenDate
            if sleepyTime.type == .fromNowTime {
                let alarmTimes = calculateFromNowTime(date: date)
                let viewModel = WakeUpTimeViewModel(alarmTimes: alarmTimes)
                viewController?.displayData(viewModel: .displayWakeUpTime(viewModel: viewModel))
            } else {
                let alarmTime = calculateToTime(date: date)
                let viewModel = SleepyTime(choosenDate: date, type: .toTime, alarmTimes: alarmTime)
                viewController?.displayData(viewModel: .displayWakeUpTime(viewModel: viewModel))
            }
        @unknown default:
            print("WakeUpTimePresenter has another response")
        }
    }
    
    private func calculateToTime(date: Date) -> [AlarmTime] {
        //        let minToFallAsleep = userDefaults.double(forKey: UserDefaultKeys.fallAsleepSlider)
        let minToFallAsleep = 0.0
        var date = Date(timeInterval: -5400 - (minToFallAsleep * 60), since: date)
        
        var alarmsArray = [AlarmTime(cyclesCount: 1, date: date)]
        for i in 1..<6 {
            date = Date(timeInterval: -5400, since: alarmsArray[i - 1].date)
            let cycle = AlarmTime(cyclesCount: i + 1, date: date)
            alarmsArray.insert(cycle, at: i)
        }
        return alarmsArray.reversed()
    }
    
    
    private func calculateFromNowTime(date: Date) -> [AlarmTime] {
        //        let minToFallAsleep = userDefaults.double(forKey: UserDefaultKeys.fallAsleepSlider)
        let minToFallAsleep = 0.0
        //к передаваемой дате добавить 1.5 часа(5400 сек) + время на засыпание ( сек)
        var date = Date(timeInterval: 5400 + (minToFallAsleep * 60), since: date)
        
        var alarmsArray = [AlarmTime(cyclesCount: 1, date: date)]
        for i in 1..<6 {
            date = Date(timeInterval: 5400, since: alarmsArray[i - 1].date)
            let cycle = AlarmTime(cyclesCount: i + 1, date: date)
            alarmsArray.insert(cycle, at: i)
        }
        return alarmsArray
    }
}
