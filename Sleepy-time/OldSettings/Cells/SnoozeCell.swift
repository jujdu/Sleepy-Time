//
//  SnoozeCell.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 24.11.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol SettingsCellProtocol {
    func set(with viewModel: OldSettingsItemProtocol)
    var settings: ManagedSettings! { get set }
}

protocol SettingsSnoozeCellProtocol {
}

class SnoozeCell: UITableViewCell, SettingsCellProtocol {
    weak var settings: ManagedSettings!
    func set(with viewModel: OldSettingsItemProtocol) {
        
    }
    
    
    static let reuseId = "SnoozeCell"
    
    //MARK: - FallAsleep Views
    let snoozeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Snooze"
        label.textAlignment = .left
        label.font = UIFont(name: AppFonts.avenirBook, size: 17)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var currentSnoozeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Never"
        label.textAlignment = .right
        label.font = UIFont(name: AppFonts.avenirLight, size: 17)
        label.numberOfLines = 1
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .trailing
        stackView.distribution = .fill
        return stackView
    }()
    
    //MARK: - Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Configuration
    private func setupConstraints() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(snoozeLabel)
        stackView.addArrangedSubview(currentSnoozeLabel)
        
        stackView.fillSuperview(padding: Constraints.cellPaddings)
    }
}
