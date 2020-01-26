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

//    var engine = AVAudioEngine()
//    var player = AVAudioPlayerNode()
//
//    var audioFile: AVAudioFile? {
//        didSet {
//            if let audioFile = audioFile {
//                audioFormat = audioFile.processingFormat
//            }
//        }
//    }
//
//    var audioFileURL: URL? {
//        didSet {
//            if let audioFileURL = audioFileURL {
//                audioFile = try? AVAudioFile(forReading: audioFileURL)
//            }
//        }
//    }
//
//    var audioFormat: AVAudioFormat?
//
//    init(playFileAt url: URL) {
//        super.init()
//        audioFileURL = url
//        engine.attach(player)
//        engine.connect(player, to: engine.mainMixerNode, format: audioFormat)
//
//        engine.prepare()
//
//        do {
//            try engine.start()
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
//
//    func scheduleAudioFile(atTime: Double) {
//        guard let audioFile = audioFile, let audioFormat = audioFormat else { return }
//
//        let startSampleTime = (player.lastRenderTime?.sampleTime)!
//
//        let startTime = AVAudioTime(sampleTime: startSampleTime + Int64(((atTime) * audioFormat.sampleRate)), atRate: audioFormat.sampleRate)
//
//        player.scheduleFile(audioFile, at: startTime) {
//            print("complete")
//        }
//    }
//
//    func startPlay(atTime: Double) {
//        scheduleAudioFile(atTime: atTime)
//        player.play()
//    }
    
    func startEngine(playFileAt: URL, atTime delayTime: Double) {
        stop()
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(Int(delayTime))) {
            do {
                try AVAudioSession.sharedInstance().setCategory(.playAndRecord, options: [.defaultToSpeaker, .duckOthers])
            } catch {
                
            }
        }

        do {

            let audioFile = try AVAudioFile(forReading: playFileAt)
            let audioFormat = audioFile.processingFormat
            let audioFrameCount = AVAudioFrameCount(audioFile.length)
            guard let audioFileBuffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: audioFrameCount) else { return }

            try audioFile.read(into: audioFileBuffer)

            //Nodes
            let player = AVAudioPlayerNode()
            let mixer = self.mainMixerNode

            self.attach(player)

            self.connect(player, to: mixer, format: audioFormat)
            self.prepare()
            
            try self.start()
            
            let rate = audioFormat.sampleRate
            let delay = AVAudioFramePosition(delayTime * rate)
            let startTime = AVAudioTime(sampleTime: delay, atRate: rate)

            player.scheduleBuffer(audioFileBuffer, at: startTime, options: .loops) {
                print("complete")
            }

            player.play()

        } catch let error as NSError {
            debugPrint(error, error.userInfo)
        }
    }
}

//let startFramePosition: AVAudioFramePosition = (player.lastRenderTime?.sampleTime)!
//let startTime = AVAudioTime(sampleTime: startFramePosition + Int64(delayTime), atRate: audioFormat.sampleRate)
//startFramePosition не нужОн. Работает через mach_absolute_time() в hostTime, или вообзе без него.
