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
    
    var engine: CustomAVAudioEngine?
    private var avEngineQueue: DispatchQueue = DispatchQueue(label: "avEngineQueue", qos: .userInitiated, attributes: .concurrent)

    var userVolumeValue: Float!

    func playRingtone(_ value: Bool, viewModel: SettingsViewModel? = nil, mpVolumeView: HiddenMPVolumeView? = HiddenMPVolumeView()) {
        if value {
            guard
                let viewModel = viewModel,
                let item = getRingtoneWithPersistentId(viewModel.ringtone.persistentId),
                let url = item.assetURL else { return }

            print(viewModel.ringtone.persistentId)
            
            engine = CustomAVAudioEngine()
            let semaphore = DispatchSemaphore(value: 1)

            userVolumeValue = AVAudioSession.sharedInstance().outputVolume
            DispatchQueue.main.async { //иначе setVolume не сработает первый раз
                mpVolumeView?.setVolume(viewModel.alarmVolume)
            }

            avEngineQueue.async {
                defer { semaphore.signal() }
                semaphore.wait()
                self.engine?.startEngine(playFileAt: url)
            }
        } else {
            mpVolumeView?.setVolume(userVolumeValue)
            engine = nil //engine долго стартует в бэке, поэтому если быстро нажимать то он стартует при состоянии: пауза. Для этого обнуляю.
        }
    }
    
//    func stopRingtone(mpVolumeView: MPVolumeView? = nil) {
//        mpVolumeView?.setVolume(userVolumeValue)
//        engine = nil //engine долго стартует в бэке, поэтому если быстро нажимать то он стартует при состоянии: пауза. Для этого обнуляю.
//    }

    private func getRingtoneWithPersistentId(_ id: String) -> MPMediaItem? {
        let predicate = MPMediaPropertyPredicate(value: id, forProperty: MPMediaItemPropertyPersistentID)
        let query = MPMediaQuery()
        query.addFilterPredicate(predicate)

        var ringtone: MPMediaItem?
        guard let items = query.items, items.count > 0 else { return nil }
        ringtone = items.first
        return ringtone
    }
    
    deinit {
        print("AVEngineWorker deinit")
    }
    
}
