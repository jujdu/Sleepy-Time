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
    
    var presenter: WakeUpTimePresentationLogic?
    var worker = SettingsWorker()
    
    var sleepyTime: SleepyTime!
    var settings: Settings?
    
    func makeRequest(request: WakeUpTime.Model.Request.RequestType) {
        switch request {
        case .getWakeUpTime:
            worker.fetchSettings { (settings) in
                self.settings = settings
                self.presenter?.presentData(response: .presentWakeUpTime(sleepyTime: self.sleepyTime, settings: settings))                
            }
        case .setWakeUpTime(let date):
            (UIApplication.shared.delegate as? AppDelegate)?.UNNotifications.scheduleNotification(atDate: date, withSettings: settings)
        }
    }
    
    private func fromSettingsToViewModel(settings: Settings) -> SettingsViewModel {
        return SettingsViewModel(snoozeTime: settings.snoozeTime,
                                 fallAsleepTime: Float(settings.fallAsleepTime),
                                 ringtone: SettingsViewModel.Ringtone(artistName: settings.ringtone.artistName,
                                                                      ringtoneName: settings.ringtone.ringtoneName,
                                                                      persistentId: settings.ringtone.persistentId ?? ""),
                                 isVibrated: settings.isVibrated,
                                 alarmVolume: Float(settings.alarmVolume))
    }
}
