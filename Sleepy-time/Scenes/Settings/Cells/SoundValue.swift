//
//  SoundValue.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 06.12.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class SoundValue: UITableViewCell {
    static let reuseId = "SoundValue"
    
    //MARK: - FallAsleep Views
    lazy var fallAsleepSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0.5
        if #available(iOS 13.0, *) {
            slider.minimumValueImage = UIImage(systemName: "speaker.fill")
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            slider.maximumValueImage = UIImage(systemName: "speaker.3.fill")
        } else {
            // Fallback on earlier versions
        }
        slider.addTarget(self, action: #selector(self.sliderChangedValue), for: .valueChanged)
        return slider
    }()
    
    
    //MARK: - Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Configuration
    private func setupConstraints() {
        contentView.addSubview(fallAsleepSlider)
        
        fallAsleepSlider.fillSuperview(padding: Constraints.cellPaddings)
    }
    
    @objc func sliderChangedValue(sender: UISlider) {
        print(sender.value)
    }
}
