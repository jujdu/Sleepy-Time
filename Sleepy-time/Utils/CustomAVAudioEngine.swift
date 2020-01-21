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
//    let mixer = AVAudioMixerNode()
    
    func startEngine(playFileAt: URL) {
        stop()
        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default, policy: .default, options: .defaultToSpeaker)
            try AVAudioSession.sharedInstance().setActive(true)
            print(try AVAudioSession.sharedInstance().availableInputs)

            let audioFile = try AVAudioFile(forReading: playFileAt)
            let audioFormat = audioFile.processingFormat
            let audioFrameCount = AVAudioFrameCount(audioFile.length)
            guard let audioFileBuffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: audioFrameCount) else { return }
            
            try audioFile.read(into: audioFileBuffer)

            //Nodes
            let player = AVAudioPlayerNode()
            let mixer = mainMixerNode
            
            attach(player)
            connect(player, to: mixer, format: audioFormat)
            prepare()
            
            try start()
            player.scheduleBuffer(audioFileBuffer, at: nil, options: .loops)
            
            player.play()
        } catch let error as NSError {
            debugPrint(error, error.userInfo)
        }
    }
}
