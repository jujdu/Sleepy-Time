//
//  CustomAVAudioEngine.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 31.12.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import Foundation
import AVFoundation

class CustomAVAudioEngine: AVAudioEngine {
    
//    static let engine = CustomAVAudioEngine()
    
    func startEngine(playFileAt: URL) {
        self.stop()
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)

            let avAudioFile = try AVAudioFile(forReading: playFileAt)
            let player = AVAudioPlayerNode()

            self.attach(player)
            self.connect(player, to: self.mainMixerNode, format: avAudioFile.processingFormat)

            try self.start()
            player.scheduleFile(avAudioFile, at: nil, completionHandler: nil)
            player.play()
        } catch {
            assertionFailure(String(describing: error))
        }
    }
}
