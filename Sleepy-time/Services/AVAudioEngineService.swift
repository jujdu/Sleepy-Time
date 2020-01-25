//
//  AVAudioEngineService.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 31.12.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import Foundation
import AVFoundation

class AVAudioEngineService: AVAudioEngine {
    
//    static let engine = AVAudioEngineService()
//    override init() {
//        super.init()
//        prepare()
//    }
    
    func startEngine(playFileAt: URL, atTime delayTime: Double) {
        stop()
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, options: [.defaultToSpeaker, .duckOthers])
            
            let audioFile = try AVAudioFile(forReading: playFileAt)
            let audioFormat = audioFile.processingFormat
            let audioFrameCount = AVAudioFrameCount(audioFile.length)
            guard let audioFileBuffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: audioFrameCount) else { return }
            
            try audioFile.read(into: audioFileBuffer)
            
            //Nodes
            let player = AVAudioPlayerNode()
            let mixer = self.mainMixerNode
            
            self.attach(player)
//

            self.connect(player, to: mixer, format: audioFormat)
            self.prepare()

            try self.start()
            player.scheduleBuffer(audioFileBuffer, at: nil, options: .loops)

            let startSampleTime = (player.lastRenderTime?.sampleTime)!

            let startTime = AVAudioTime(sampleTime: startSampleTime + Int64(((delayTime - 0.5) * audioFormat.sampleRate)), atRate: audioFormat.sampleRate)
            player.play(at: startTime)
            
        } catch let error as NSError {
            debugPrint(error, error.userInfo)
        }
        
        do {
     
        } catch {
            print(error.localizedDescription)
        }
    }
}
