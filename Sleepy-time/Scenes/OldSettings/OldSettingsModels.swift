//
//  OldSettingsModels.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 26.11.2019.
//  Copyright (c) 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

enum OldSettings {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getSettings(settings: ManagedSettings)
            }
        }
        struct Response {
            enum ResponseType {
                case presentSettings(settings: ManagedSettings)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displaySettings(viewModel: OldSettingsViewModel)
            }
        }
    }
    
}

struct OldSettingsViewModel {
    var items: [OldSettingsItemProtocol]
}

//MARK: - SettingsItemType
enum OldSettingsItemType {
    case snooze
    case fallAlseep
    case song
    case soundValue
    case soundVibration
    
    func registerCell(tableView: UITableView) {
        switch self {
        case .snooze:
            tableView.register(SnoozeCell.self, forCellReuseIdentifier: SnoozeCell.reuseId)
        case .fallAlseep:
            tableView.register(TimeToFallAsleepCell.self, forCellReuseIdentifier: TimeToFallAsleepCell.reuseId)
        case .song:
            tableView.register(SongCell.self, forCellReuseIdentifier: SongCell.reuseId)
        case .soundValue:
            tableView.register(SoundValueCell.self, forCellReuseIdentifier: SoundValueCell.reuseId)
        case .soundVibration:
            tableView.register(SoundVibrationCell.self, forCellReuseIdentifier: SoundVibrationCell.reuseId)
        }
    }
    
    func cellForSettingsItemType(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        switch self {
        case .snooze:
            return tableView.dequeueReusableCell(withIdentifier: SnoozeCell.reuseId, for: indexPath) as! SnoozeCell
        case .fallAlseep:
            return tableView.dequeueReusableCell(withIdentifier: TimeToFallAsleepCell.reuseId, for: indexPath) as! TimeToFallAsleepCell
        case .song:
            return tableView.dequeueReusableCell(withIdentifier: SongCell.reuseId, for: indexPath) as! SongCell
        case .soundValue:
            return tableView.dequeueReusableCell(withIdentifier: SoundValueCell.reuseId, for: indexPath) as! SoundValueCell
        case .soundVibration:
            return tableView.dequeueReusableCell(withIdentifier: SoundVibrationCell.reuseId, for: indexPath) as! SoundVibrationCell
        }
    }
    
    func configureCellForModelItemType(cell: UITableViewCell, data: OldSettingsItemProtocol, settings: ManagedSettings) {
        switch self {
            case .snooze:
                 let cell = cell as! SnoozeCell
                 cell.settings = settings
                 cell.set(with: data)
             case .fallAlseep:
                 let cell = cell as! TimeToFallAsleepCell
                 cell.settings = settings
                 cell.set(with: data)
             case .song:
                 let cell = cell as! SongCell
                 cell.settings = settings
                 cell.set(with: data)
             case .soundValue:
                 let cell = cell as! SoundValueCell
                 cell.settings = settings
                 cell.set(with: data)
             case .soundVibration:
                 let cell = cell as! SoundVibrationCell
                 cell.settings = settings
                 cell.set(with: data)
        }
    }
}

//MARK: - SettingsItemProtocol
protocol OldSettingsItemProtocol {
    var type: OldSettingsItemType { get }
    var rowsCount: Int { get }
    var sectionTitle: String? { get }
    var sectionHeight: CGFloat { get }
}

extension OldSettingsItemProtocol {
    var rowsCount: Int { return 1 }
    var sectionTitle: String? { return nil }
    var sectionHeight: CGFloat { return 0 }
}

// MARK: - Implementation SettingsSnoozeItem
class OldSettingsSnoozeItem: OldSettingsItemProtocol, SettingsSnoozeCellProtocol {
    var type: OldSettingsItemType = .snooze
}

// MARK: - Implementation SettingsFallAlseepItem
class OldSettingsFallAlseepItem: OldSettingsItemProtocol, SettingsFallAlseepCellProtocol {
    var value: Double
    var type: OldSettingsItemType = .fallAlseep
    
    init(value: Double) {
        self.value = value
    }
}

// MARK: - Implementation SettingsSongItem
class OldSettingsSongItem: OldSettingsItemProtocol, SettingsSongCellProtocol {
    var type: OldSettingsItemType = .song
    var sectionTitle: String? = "SOUND"
    var sectionHeight: CGFloat = 36
}

// MARK: - Implementation SettingsSoundLabel
class OldSettingsSoundValueItem: OldSettingsItemProtocol, SettingsSoundValueCellProtocol {
    var volume: Double
    var type: OldSettingsItemType = .soundValue
    
    init(volume: Double) {
        self.volume = volume
    }
}

class OldSettingsSoundVibrationItem: OldSettingsItemProtocol, SettingsSoundVibrationCellProtocol {
    var value: Bool
    var type: OldSettingsItemType = .soundVibration
    
    init(value: Bool) {
        self.value = value
    }
}
