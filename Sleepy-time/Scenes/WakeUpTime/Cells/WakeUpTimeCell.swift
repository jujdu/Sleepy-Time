//
//  WakeUpTimeCell.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 18/09/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class WakeUpTimeCell: UITableViewCell {
    
    static let reuseId = "WakeUpTimeCell"
    
    //MARK: - Cycle Views. Left side
    let cycleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()
    
    let cycleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Book", size: 18)
        label.numberOfLines = 1
        return label
    }()
    
    let hoursLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Book", size: 15)
        label.numberOfLines = 1
        return label
    }()
    
    //MARK: - Time View. Right side
    let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .right
        label.font = UIFont(name: "Avenir-Book", size: 32)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var alarmButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "ic_add_alarm_36pt"), for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 5
        button.contentHorizontalAlignment = .right
        button.isUserInteractionEnabled = false
//        button.addTarget(self, action: #selector(handleButtonTapped), for: .touchUpInside)
        return button
    }()
    
//    var closure: ((Date) -> ())?
    
//    @objc func handleButtonTapped() {
//        closure?(Date())
//    }
    
    //MARK: - Common Stack View
    let commonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0
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
        commonStackView.addArrangedSubview(cycleStackView)
        commonStackView.addArrangedSubview(timeLabel)
        cycleStackView.addArrangedSubview(cycleLabel)
        cycleStackView.addArrangedSubview(hoursLabel)
        
        commonStackView.fillSuperview(padding: Constraints.cellPaddings)
        alarmButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    func set(alarmTime: WakeUpTimeViewModel.Cell, cellType: AlarmTimeType) {
        if cellType == .fromNowTime {
            commonStackView.addArrangedSubview(alarmButton)
        }
        cycleLabel.text = "Cycles: \(alarmTime.cyclesCount)"
        hoursLabel.text = foundSleepyHours(index: alarmTime.cyclesCount)
        timeLabel.text = alarmTime.date.shortStyleString()
    }
    
    func foundSleepyHours(index: Int) -> String {
        let time = 1.5 * Double(index)
        
        if floor(time) == time {
            return "\(Int(time)) sleepy hours"
        } else {
            return "\(time) sleepy hours"
        }
    }
}

