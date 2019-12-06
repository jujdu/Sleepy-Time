//
//  SettingsModels.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 26.11.2019.
//  Copyright (c) 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

enum Settings {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getSettings
            }
        }
        struct Response {
            enum ResponseType {
                case presentSettings
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displaySettings(viewModel: SettingsViewModel)
            }
        }
    }
    
}

struct SettingsViewModel {
    var items: [SettingsItemProtocol]
}

//MARK: - SettingsItemType
enum SettingsItemType {
    case snooze
    case fallAlseep
    case song
    case soundValue
    
    func cellForSettingsItemType(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        switch self {
        case .snooze:
            return tableView.dequeueReusableCell(withIdentifier: SnoozeCell.reuseId, for: indexPath) as! SnoozeCell
        case .fallAlseep:
            return tableView.dequeueReusableCell(withIdentifier: TimeToFallAsleepCell.reuseId, for: indexPath) as! TimeToFallAsleepCell
        case .song:
            return tableView.dequeueReusableCell(withIdentifier: SongCell.reuseId, for: indexPath) as! SongCell
        case .soundValue:
            return tableView.dequeueReusableCell(withIdentifier: SoundValue.reuseId, for: indexPath) as! SoundValue
        }
    }
}

//MARK: - SettingsItemProtocol
protocol SettingsItemProtocol {
    var type: SettingsItemType { get }
    var rowsCount: Int { get }
    var sectionTitle: String? { get }
    var sectionHeight: CGFloat { get }
}

extension SettingsItemProtocol {
    var rowsCount: Int { return 1 }
    var sectionTitle: String? { return nil }
    var sectionHeight: CGFloat { return 0 }
}

// MARK: - Implementation SettingsSnoozeItem
class SettingsSnoozeItem: SettingsItemProtocol {
    var type: SettingsItemType = .snooze
}

// MARK: - Implementation SettingsFallAlseepItem
class SettingsFallAlseepItem: SettingsItemProtocol {
    var type: SettingsItemType = .fallAlseep
}

// MARK: - Implementation SettingsSongItem
class SettingsSongItem: SettingsItemProtocol {
    var type: SettingsItemType = .song
    var sectionTitle: String? = "SOUND"
    var sectionHeight: CGFloat = 30
}

// MARK: - Implementation SettingsSoundLabel
class SettingsSoundValueItem: SettingsItemProtocol {
    var type: SettingsItemType = .soundValue
}
