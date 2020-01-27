//
//  AVAudioSession.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 27.01.2020.
//  Copyright © 2020 Michael Sidoruk. All rights reserved.
//

import Foundation
import AVFoundation

public func avAudioSessionPlayAndRecord(afterTime time: Double) {
    DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(Int(time))) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, options: [.defaultToSpeaker, .duckOthers])
        } catch {
            print(error.localizedDescription)
        }
    }
}

public func avAudioSessionPlayback() {
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, options: [.mixWithOthers])
    } catch let error as NSError{
        print(error.localizedDescription)
    }
}


