//
//  FromNowCycleCell.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 18/09/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class ToTimeCycleCell: UITableViewCell {
    
    static let reuseId = "ToTimeCycleCell"
    
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
        label.font = UIFont(name: "Avenir-Book", size: 17)
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
        label.font = UIFont(name: "Avenir-Book", size: 35)
        label.numberOfLines = 1
        return label
    }()
    
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
        addSubview(commonStackView)
        commonStackView.addArrangedSubview(cycleStackView)
        commonStackView.addArrangedSubview(timeLabel)
        cycleStackView.addArrangedSubview(cycleLabel)
        cycleStackView.addArrangedSubview(hoursLabel)
        
        commonStackView.fillSuperview(padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
    
    func setupUI(cycle: AlarmTime) {
        cycleLabel.text = "Cycles: \(cycle.cycles)"
        hoursLabel.text = foundSleepyHours(index: cycle.cycles)
        timeLabel.text = cycle.stringDate
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

