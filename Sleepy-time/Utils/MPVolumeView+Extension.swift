//
//  MPVolumeView+Extension.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 31.12.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import MediaPlayer
import UIKit

extension MPVolumeView {
    private var slider: UISlider? {
        let volumeView = MPVolumeView()
        return volumeView.subviews.first as? UISlider
    }
    func setVolume(_ value: Float) {
        if let slider = slider {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                slider.value = value
            }
        }
    }
}
