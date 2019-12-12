//
//  SongCell.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 24.11.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol SettingsSongCellProtocol {
    
}

class SongCell: UITableViewCell, SettingsCellProtocol {
    weak var settings: SettingsDataBase!
    
    func set(with viewModel: SettingsItemProtocol) {
        
    }
    
    
    static let reuseId = "SongCell"
    
    //MARK: - FallAsleep Views
    let songLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ringtone"
        label.textAlignment = .left
        label.font = UIFont(name: AppFonts.avenirBook, size: 17)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var currentSongLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "The Weeknd - Starboy"
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
        stackView.addArrangedSubview(songLabel)
        stackView.addArrangedSubview(currentSongLabel)
        
        stackView.fillSuperview(padding: Constraints.cellPaddings)
    }
}
