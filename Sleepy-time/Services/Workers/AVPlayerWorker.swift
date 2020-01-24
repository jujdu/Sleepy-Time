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
    
    var player: AVAudioPlayer?
    private var avPlayerQueue: DispatchQueue = DispatchQueue(label: "avPlayerQueue", qos: .userInitiated, attributes: .concurrent)

    var userVolumeValue: Float!

    func playRingtone(_ value: Bool, viewModel: SettingsViewModel? = nil, mpVolumeView: HiddenMPVolumeView? = HiddenMPVolumeView()) {
        
        if value {
            guard
                let viewModel = viewModel,
                let item = AVEngineWorker.getRingtoneWithPersistentId(viewModel.ringtone.persistentId),
                let url = item.assetURL else { return }

            print(viewModel.ringtone.persistentId)
            
            let semaphore = DispatchSemaphore(value: 1)

            userVolumeValue = AVAudioSession.sharedInstance().outputVolume
            DispatchQueue.main.async { //иначе setVolume не сработает первый раз
                mpVolumeView?.setVolume(viewModel.alarmVolume)
            }

            avPlayerQueue.async {
                defer { semaphore.signal() }
                
                do {
                    self.player = try AVAudioPlayer(contentsOf: url)
                    guard let player = self.player else { return }
                    self.player?.play(atTime: player.deviceCurrentTime + 60)
                } catch {
                    print("error")
                }
                
                semaphore.wait()
            }
        } else {
            mpVolumeView?.setVolume(userVolumeValue)
            self.player = nil
        }
    }
}
