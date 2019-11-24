//
//  SnoozeCell.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 24.11.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class SnoozeCell: UITableViewCell {
    
    static let reuseId = "SnoozeCell"

    //MARK: - Repeat Views

    lazy var repeatLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            label.textColor = .label
        } else {
            // Fallback on earlier versions
        }
        label.text = generatedTextForLabel(self.repeatSlider.value)
        label.textAlignment = .left
        label.font = UIFont(name: AppFonts.avenirBook, size: 17)
        label.numberOfLines = 1
        return label
    }()
    
    let repeatSwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.translatesAutoresizingMaskIntoConstraints = false
        mySwitch.isOn = false
        return mySwitch
    }()
    
    let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var repeatSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 1
        slider.maximumValue = 30
        slider.value = 5
        slider.addTarget(self, action: #selector(self.sliderChangedValue), for: .valueChanged)
        return slider
    }()
    
    let commonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 4
        stackView.distribution = .fill
        return stackView
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
        contentView.addSubview(commonStackView)
        topStackView.addArrangedSubview(repeatLabel)
        topStackView.addArrangedSubview(repeatSwitch)
        commonStackView.addArrangedSubview(topStackView)
        commonStackView.addArrangedSubview(repeatSlider)
        
        commonStackView.fillSuperview(padding: Constraints.cellPaddings)
    }
    
    @objc func sliderChangedValue(sender: UISlider) {
        print(sender.value)
        repeatLabel.text = generatedTextForLabel(sender.value)    }
    
    func generatedTextForLabel(_ value: Float) -> String {
        return "Repeat alarm every: \(Int(value)) min"
    }
}
