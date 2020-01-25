//
//  AVPlayerWorker.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 24.01.2020.
//  Copyright © 2020 Michael Sidoruk. All rights reserved.
//

import UIKit
import MediaPlayer

class AVPlayerWorker {
    
    static let shared = AVPlayerWorker()
    
    var player: AVAudioPlayer?
    private var avPlayerQueue: DispatchQueue = DispatchQueue(label: "avPlayerQueue", qos: .userInitiated, attributes: .concurrent)
    let mpVolumeView: HiddenMPVolumeView = HiddenMPVolumeView()
    
    var userVolumeValue: Float!
    
    private init() {
        self.userVolumeValue = AVAudioSession.sharedInstance().outputVolume
    }
    
    func startRingtone(viewModel: SettingsViewModel?) {
        startRingtone(atTime: 0, viewModel: viewModel)
    }
    func startRingtone(atTime: Double, viewModel: SettingsViewModel?) {
        addNotificationObserverForVibration()
        guard
            let viewModel = viewModel,
            let item = AVAudioEngineWorker.getRingtoneWithPersistentId(viewModel.ringtone.persistentId),
            let url = item.assetURL else { return }
        
        print(viewModel.ringtone.persistentId)
        
        let semaphore = DispatchSemaphore(value: 1)
        
        Timer.scheduledTimer(withTimeInterval: atTime, repeats: false) { (_) in
            DispatchQueue.main.async { //иначе setVolume не сработает первый раз
                self.mpVolumeView.setVolume(viewModel.alarmVolume)
            }
            do {
                try AVAudioSession.sharedInstance().setCategory(.playAndRecord, options: [.duckOthers])
                try AVAudioSession.sharedInstance().overrideOutputAudioPort(.speaker)
            } catch {
                print(error)
            }
        }
        
        avPlayerQueue.async {
            defer { semaphore.signal() }
            do {
                self.player = try AVAudioPlayer(contentsOf: url)
                guard let player = self.player else { return }
                player.play(atTime: player.deviceCurrentTime + atTime)
            } catch {
                print("error")
            }
            semaphore.wait()
        }
        
        if viewModel.isVibrated {
            self.startVibrate(atTime: atTime)
        }
    }
    
    func stopRingtone() {
        self.stopVibrate()
        self.mpVolumeView.setVolume(userVolumeValue)
        player = nil
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, options: .mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(error.localizedDescription)
        }
        
        let nc = NotificationCenter.default
        nc.removeObserver(self)
    }
    
    //MARK: - Start Stop Vibration
    func startVibrate() {
        self.startVibrate(atTime: 0)
    }
    
    private func startVibrate(atTime time: Double) {
        
        Timer.scheduledTimer(withTimeInterval: time, repeats: false) { (_) in
            //vibrate phone first
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
        
        if isActive && player != nil {
            startVibrate()
        } else {
            stopVibrate()
        }
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
}
