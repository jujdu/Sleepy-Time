//
//  AVEngineWorker.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 04.01.2020.
//  Copyright © 2020 Michael Sidoruk. All rights reserved.
//

import UIKit
import MediaPlayer

class AVEngineWorker {
    
    //MARK: - Properties
    var engine: CustomAVAudioEngine?
    let mpVolumeView: HiddenMPVolumeView = HiddenMPVolumeView()
    
    var userVolumeValue: Float
    
    private var avEngineQueue: DispatchQueue = DispatchQueue(label: "avEngineQueue", qos: .userInitiated, attributes: .concurrent)

    //MARK: - Init
    required init() {
        self.userVolumeValue = AVAudioSession.sharedInstance().outputVolume
        self.addNotificationObserverForVibration()
    }
    
    //MARK: - Start Stop Ringtone Methods
    func startRingtone(viewModel: SettingsViewModel?) {
        self.startRingtone(atTime: 0, viewModel: viewModel)
    }

    func startRingtone(atTime time: Double, viewModel: SettingsViewModel?) {
        
        guard
            let viewModel = viewModel,
            let item = AVEngineWorker.getRingtoneWithPersistentId(viewModel.ringtone.persistentId),
            let url = item.assetURL else {
                print("Cannot get url from given persistentId")
                return }
        
        print(viewModel.ringtone.persistentId)
        
        engine = CustomAVAudioEngine()
        engine?.mainMixerNode.outputVolume = viewModel.alarmVolume
        
        let semaphore = DispatchSemaphore(value: 1)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            self.mpVolumeView.setVolume(viewModel.alarmVolume)
        }
        
        avEngineQueue.async {
            defer { semaphore.signal() }
            semaphore.wait()
            self.engine?.startEngine(playFileAt: url, atTime: time)
        }
        
        if viewModel.isVibrated {
            self.startVibrate(atTime: time)
        }
    }
    
    func stopRingtone() {
        self.stopVibrate()
        self.mpVolumeView.setVolume(userVolumeValue)
        engine = nil //engine долго стартует в бэке, поэтому если быстро нажимать то он стартует при состоянии: пауза. Для этого обнуляю.
    }
    
    //MARK: - Support Methods
    public static func getRingtoneWithPersistentId(_ id: String) -> MPMediaItem? {
        let predicate = MPMediaPropertyPredicate(value: id, forProperty: MPMediaItemPropertyPersistentID)
        let query = MPMediaQuery()
        query.addFilterPredicate(predicate)

        var ringtone: MPMediaItem?
        guard let items = query.items, items.count > 0 else { return nil }
        ringtone = items.first
        return ringtone
    }
    
    //MARK: - Start Stop Vibration
    func startVibrate() {
        self.startVibrate(atTime: 0)
    }
    
    private func startVibrate(atTime time: Double) {
        //vibrate phone first
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            //set vibrate when kSystemSoundID_Vibrate is completed. Kind of recursion
            AudioServicesAddSystemSoundCompletion(kSystemSoundID_Vibrate,
                                                  nil,
                                                  nil,
                                                  { _,_ in
                                                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate) },
                                                  nil)
        }
    }
    
    private func stopVibrate() {
        AudioServicesRemoveSystemSoundCompletion(kSystemSoundID_Vibrate)
    }
    
    //MARK: - Notification observe for Vibration
    private func addNotificationObserverForVibration() {
        let nc = NotificationCenter.default
        nc.addObserver(self,
                       selector: #selector(startStopVibrationByNotification(notification:)),
                       name: .startStopVibrationFromNotification,
                       object: nil)
    }
    
    @objc func startStopVibrationByNotification(notification: Notification) {
        guard
            let dic = notification.userInfo as? [Notification.Name: Bool],
            let isActive = dic[.startStopVibrationFromNotification] else { return }

        if isActive && engine != nil {
            startVibrate()
        } else {
            stopVibrate()
        }
    }
    
    //MARK: - Deinit
    deinit {
        let nc = NotificationCenter.default
        nc.removeObserver(self)
        print("AVEngineWorker deinit")
    }
}
