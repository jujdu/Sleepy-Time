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
    
    func startEngine(playFileAt: URL, atTime delayTime: Double) {
        stop()
        do {
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
            
            let startSampleTime = (player.lastRenderTime?.sampleTime)!

            let startTime = AVAudioTime(sampleTime: startSampleTime + Int64((delayTime * audioFormat.sampleRate)), atRate: audioFormat.sampleRate)
            player.play(at: startTime)
            
            //also works
//            DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
//                player.play()
//            }

        } catch let error as NSError {
            debugPrint(error, error.userInfo)
        }
    }
}
