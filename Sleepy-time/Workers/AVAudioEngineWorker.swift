//
//  AVAudioEngineWorker.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 04.01.2020.
//  Copyright © 2020 Michael Sidoruk. All rights reserved.
//

import UIKit
import MediaPlayer

class AVAudioEngineWorker {
    
    //MARK: - Properties
    static let shared = AVAudioEngineWorker()
    
    var engine: AVAudioEngineService?
    let mpVolumeView: HiddenMPVolumeView = HiddenMPVolumeView()
    var isPlaying = false
    var userVolumeValue: Float
    
    private var avEngineQueue = DispatchQueue(label: "avEngineQueue", qos: .userInitiated, attributes: .concurrent)
    private let semaphore = DispatchSemaphore(value: 1)
    
    //MARK: - Init
    private init() {
        self.userVolumeValue = AVAudioSession.sharedInstance().outputVolume
    }
    
    //MARK: - Start/Stop Ringtone Methods
    func startRingtone(settings: Settings?) {
        self.startRingtone(atTime: 0, settings: settings)
    }
    
    func startRingtone(atTime time: Double, settings: Settings?) {
        self.addNotificationObserverForVibration()
        
        guard
            let settings = settings,
            let item = AVAudioEngineWorker.getRingtoneWithPersistentId(settings.ringtone.persistentId),
            let url = item.assetURL else {
                print("Cannot get url from given persistentId")
                return }
        
        print(item)
        
        self.engine = AVAudioEngineService()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int(time))) {
            self.userVolumeValue = AVAudioSession.sharedInstance().outputVolume
            self.mpVolumeView.setVolume(Float(settings.alarmVolume))
            self.engine?.mainMixerNode.outputVolume = Float(settings.alarmVolume)
            self.isPlaying = true
        }

        avAudioSessionPlayAndRecord(afterTime: time)

        self.avEngineQueue.async() {
            defer { self.semaphore.signal() }
            self.semaphore.wait()
            self.engine?.startEngine(playFileAt: url, atTime: time)
        }
        
        if settings.isVibrated {
            VibrationService.startVibrate(afterDelayTime: time)
        }
    }
    
    func stopRingtone() {
        UIApplication.shared.applicationIconBadgeNumber = 0
        print(#function)
        VibrationService.stopVibrate()
        self.mpVolumeView.setVolume(userVolumeValue)
        engine = nil //engine долго стартует, поэтому если быстро нажимать то он стартует при состоянии: пауза. Для этого обнуляю.
        
        avAudioSessionPlayback()
        
        NotificationCenter.default.removeObserver(self)
        
        isPlaying = false
    }
    
    //MARK: - Notification observe for Vibration
    private func addNotificationObserverForVibration() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(startStopVibrationByNotification(notification:)),
                                               name: .startStopVibrationFromNotification,
                                               object: nil)
    }
    
    @objc private func startStopVibrationByNotification(notification: Notification) {
        guard
            let dic = notification.userInfo as? [Notification.Name: Bool],
            let isActive = dic[.startStopVibrationFromNotification] else { return }
        
        if isActive && engine != nil {
            VibrationService.startVibrate()
        } else {
            VibrationService.stopVibrate()
        }
    }
    
    //MARK: - Support Methods
    public static func getRingtoneWithPersistentId(_ id: String?) -> MPMediaItem? {
        guard let id = id else { return nil }
        let predicate = MPMediaPropertyPredicate(value: id, forProperty: MPMediaItemPropertyPersistentID)
        let query = MPMediaQuery()
        query.addFilterPredicate(predicate)
        
        var ringtone: MPMediaItem?
        guard let items = query.items, items.count > 0 else { return nil }
        ringtone = items.first
        return ringtone
    }
}



        
//        DispatchQueue.main.asyncAfter(wallDeadline: .now() + time) {
//            //vibrate phone first
//                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
//                //set vibrate when kSystemSoundID_Vibrate is completed. Kind of recursion
//                AudioServicesAddSystemSoundCompletion(kSystemSoundID_Vibrate,
//                                                      nil,
//                                                      nil,
//                                                      { _,_ in
//                                                        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate) },
//                                                      nil)
//        }
                
        
        //        let backgroundTaskID = UIApplication.shared.beginBackgroundTask(expirationHandler: { [weak self] in
        //            guard let taskId = self?.backgroundTaskID else { return }
        //            UIApplication.shared.endBackgroundTask(taskId)
        //        })
        //        DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + LoopInterval.currentInterval) { [weak self] in
        //            guard let strongSelf = self,
        //                  let currentSession = strongSelf.playbackSessionId, session == currentSession else { return }
        //            strongSelf.startPlayingRecordInLoop(audioTrack, success: successHandler, failure: failureHandler)
        //            if let backgroundTaskID = strongSelf.backgroundTaskID {
        //                UIApplication.shared.endBackgroundTask(backgroundTaskID)
        //                strongSelf.backgroundTaskID = nil
        //            }
        //        }
