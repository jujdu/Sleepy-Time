//
//  SoundVibrationCell.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 09.12.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol SettingsSoundVibrationCellProtocol {
    var value: Bool { get set }
}

class SoundVibrationCell: UITableViewCell, SettingsCellProtocol {
    weak var settings: ManagedSettings!
    
    func set(with viewModel: OldSettingsItemProtocol) {
        guard let viewModel = viewModel as? SettingsSoundVibrationCellProtocol else { return }
        switchController.isOn = viewModel.value
    }
    
    
    static let reuseId = "SoundVibrationCell"
    
    //MARK: - Views
    let vibrationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Vibration"
        label.textAlignment = .left
        label.font = UIFont(name: AppFonts.avenirBook, size: 17)
        label.numberOfLines = 1
        return label
    }()
    
    let switchController: UISwitch = {
        let switchController = UISwitch()
        switchController.translatesAutoresizingMaskIntoConstraints = false
        switchController.isOn = true
        return switchController
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
        setupConstraints()
        switchController.addTarget(self, action: #selector(switchChangedValue(sender:)), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Configuration
    private func setupConstraints() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(vibrationLabel)
        stackView.addArrangedSubview(switchController)

        stackView.fillSuperview(padding: Constraints.cellPaddings)
        vibrationLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    @objc func switchChangedValue(sender: UISwitch) {
        settings.isVibrated = sender.isOn as NSNumber
    }
}
