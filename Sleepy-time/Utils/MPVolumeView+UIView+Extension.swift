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

class HiddenMPVolumeView: UIView {
    
    private var mpVolumeView: MPVolumeView
    
    func setVolume(_ value: Float) {
        mpVolumeView.setVolume(value)
    }
    
    ///Initialize a hidden MPVolumeView. To work properly, you must add this view as subview on you View Controller's view.
    init() {
        self.mpVolumeView = MPVolumeView()
        super.init(frame: .zero)
        mpVolumeView.clipsToBounds = true
        self.addSubview(mpVolumeView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
