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
            
            let rate = audioFormat.sampleRate
            let delay = AVAudioFramePosition((0.5 + delayTime) * rate)
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


//    var engine = AVAudioEngine()
//    var player = AVAudioPlayerNode()
//
//    var audioFileURL: URL {
//        didSet {
//            print(audioFileURL)
////            if let audioFileURL = audioFileURL {
//                audioFile = try? AVAudioFile(forReading: audioFileURL)
////            }
//        }
//    }
//
//    var audioFile: AVAudioFile? {
//        willSet {
//        didSet {
//            if let audioFile = audioFile {
//                audioFormat = audioFile.processingFormat
//            }
//        }
//    }
//
//    var audioFormat: AVAudioFormat? {
//        didSet {
//            if let audioFormat = audioFormat {
//                let audioFrameCount = AVAudioFrameCount(audioFile!.length)
//                audioBuffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: audioFrameCount)
//            }
//        }
//    }
//
//    var audioBuffer: AVAudioPCMBuffer?
//
//    init(withUrl url: URL) {
//        audioFileURL = url
//
//        do {
//            if let audioBuffer = audioBuffer {
//                try audioFile?.read(into: audioBuffer)
//            }
//        } catch let error {
//            print(error.localizedDescription)
//        }
//
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
//        super.init()
//    }
//
//    func scheduleBuffer(atTime: Double) {
//        let rate = audioFormat?.sampleRate
//        let delay = AVAudioFramePosition(atTime * rate!)
//        let startTime = AVAudioTime(sampleTime: delay, atRate: rate!)
//
//        player.scheduleBuffer(audioBuffer!, at: startTime, options: .loops) {
//            print("complete")
//        }
//    }
//
//    func startPlay(atTime: Double) {
////        scheduleBuffer(atTime: atTime)
////        player.play()
//    }
