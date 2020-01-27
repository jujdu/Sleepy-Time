//
//  VibrationService.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 27.01.2020.
//  Copyright © 2020 Michael Sidoruk. All rights reserved.
//

import Foundation
import AVFoundation

class VibrationService {
    static func startVibrate() {
        startVibrate(afterDelayTime: 0)
    }
    
    static func startVibrate(afterDelayTime delayTime: Double) {
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(Int(delayTime))) {
            //vibrate phone first
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            //set vibrate when kSystemSoundID_Vibrate is completed. Kind of recursion
            AudioServicesAddSystemSoundCompletion(kSystemSoundID_Vibrate,
                                                  nil,
                                                  nil,
                                                  { _,_ in
                                                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate) },
                                                  nil)
        }
    }
    
    static func stopVibrate() {
        AudioServicesRemoveSystemSoundCompletion(kSystemSoundID_Vibrate)
    }
}
