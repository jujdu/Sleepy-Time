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
        case .presentWakeUpTime(let sleepyTime, let settings):
            let date = sleepyTime.choosenDate
            if sleepyTime.type == .toTime {
                let alarmTime = calculateToTime(choosenDate: date, fallAsleepTime: settings?.fallAsleepTime)
                let viewModel = WakeUpTimeViewModel(sleepyTime: sleepyTime, cells: alarmTime)
                viewController?.displayData(viewModel: .displayWakeUpTime(viewModel: viewModel))
            } else {
                let alarmTimes = calculateFromNowTime(choosenDate: date, fallAsleepTime: settings?.fallAsleepTime)
                let viewModel = WakeUpTimeViewModel(sleepyTime: sleepyTime, cells: alarmTimes)
                viewController?.displayData(viewModel: .displayWakeUpTime(viewModel: viewModel))
            }
        @unknown default:
            print("WakeUpTimePresenter has another response")
        }
    }
    
    //MARK: - Support methods
    private func calculateToTime(choosenDate: Date, fallAsleepTime: Int?) -> [WakeUpTimeViewModel.Cell] {
        let minToFallAsleep = Double(fallAsleepTime ?? 0)
        var date = Date(timeInterval: -5400 - (minToFallAsleep * 60), since: choosenDate)
        
        var alarmsArray = [WakeUpTimeViewModel.Cell(cyclesCount: 1, date: date)]
        for i in 1..<6 {
            date = Date(timeInterval: -5400, since: alarmsArray[i - 1].date)
            let cycle = WakeUpTimeViewModel.Cell(cyclesCount: i + 1, date: date)
            alarmsArray.insert(cycle, at: i)
        }
        return alarmsArray.reversed()
    }
    
    
    private func calculateFromNowTime(choosenDate: Date, fallAsleepTime: Int?) -> [WakeUpTimeViewModel.Cell] {
        let minToFallAsleep = Double(fallAsleepTime ?? 0)
        //к передаваемой дате добавить 1.5 часа(5400 сек) + время на засыпание ( сек)
        var date = Date(timeInterval: 5400 + (minToFallAsleep * 60), since: choosenDate)
        
        var alarmsArray = [WakeUpTimeViewModel.Cell(cyclesCount: 1, date: date)]
        for i in 1..<6 {
            date = Date(timeInterval: 5400, since: alarmsArray[i - 1].date)
            let cycle = WakeUpTimeViewModel.Cell(cyclesCount: i + 1, date: date)
            alarmsArray.insert(cycle, at: i)
        }
        return alarmsArray
    }
}
