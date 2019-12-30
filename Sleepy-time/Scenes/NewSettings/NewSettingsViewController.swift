//
//  TableViewController.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 12.12.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation
import CoreData

protocol NewSettingsDisplayLogic: class {
    func displayData(viewModel: NewSettings.Model.ViewModel.ViewModelData)
}

class NewSettingsViewController: UITableViewController, NewSettingsDisplayLogic {
    
    //MARK: - @IBOutlets
    @IBOutlet weak var snoozeTimeLabel: UILabel!
    @IBOutlet weak var fallAsleepTimeLabel: UILabel!
    @IBOutlet weak var fallAsleepSlider: UISlider!
    @IBOutlet weak var ringtonePlayButton: UIButton!
    @IBOutlet weak var ringtoneNameLabel: UILabel!
    @IBOutlet weak var ringtoneVibrationSwitch: UISwitch!
    @IBOutlet weak var ringtoneVolumeSlider: UISlider!
    
    // MARK: - Properties
    var interactor: NewSettingsBusinessLogic?
    var router: (NSObjectProtocol & NewSettingsRoutingLogic & NewSettingsDataPassing)?
    private lazy var mediaPicker = MPMediaPickerController.self(mediaTypes: .music)
    private lazy var engine = CustomAVAudioEngine()
//    private let player = AVPlayer()
//    private let avplayer = AVAudioPlayer()
    
    private var isPlaying: Bool = false {
        willSet {
            if newValue {
                print("persistentId: \(viewModel.ringtone.persistentId)")
                guard let item = getRingtoneWithPersistentId(viewModel.ringtone.persistentId), let url = item.assetURL else {
                    print("Something else")
                    return }
                engine.startEngine(playFileAt: url)
                ringtonePlayButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            } else {
                engine.stop()
                ringtonePlayButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            }
        }
    }
    
    var context: NSManagedObjectContext!
    var viewModel: SettingsViewModel!
    
    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = NewSettingsInteractor()
        let presenter             = NewSettingsPresenter()
        let router                = NewSettingsRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
        router.dataStore          = interactor
    }
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        context = (UIApplication.shared.delegate as! AppDelegate).coreDataStack.persistentContainer.viewContext
        setupMediaPicker()
        setupNavigationBar()
        interactor?.makeRequest(request: .getSettings)
    }

    func displayData(viewModel: NewSettings.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displaySettings(let viewModel):
            self.viewModel = viewModel
            set(viewModel: viewModel)
        @unknown default:
            print("SettingsViewController has another response")
        }
    }
    
    //MARK: - Methods
    func set(viewModel: SettingsViewModel) {
        if let snoozeTime = viewModel.snoozeTime {
            snoozeTimeLabel.text = "\(snoozeTime) min"
        } else {
            snoozeTimeLabel.text = "Never"
        }
        
        fallAsleepTimeLabel.text = "\(Int(viewModel.fallAsleepTime)) min"
        fallAsleepSlider.value = viewModel.fallAsleepTime
        ringtoneNameLabel.text = "\(viewModel.ringtone.artistName) - \(viewModel.ringtone.ringtoneName)"
        ringtoneVibrationSwitch.isOn = viewModel.isVibrated
        ringtoneVolumeSlider.value = viewModel.alarmVolume
    }
    
    private func setupMediaPicker() {
        mediaPicker.allowsPickingMultipleItems = false
        mediaPicker.showsCloudItems = false
        mediaPicker.showsItemsWithProtectedAssets = false
        mediaPicker.delegate = self
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.label,
            NSAttributedString.Key.font: UIFont(name: AppFonts.avenirHeavy, size: 18)!
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.label,
            NSAttributedString.Key.font: UIFont(name: AppFonts.avenirHeavy, size: 32)!
        ]
    }
    
    //MARK: - @IBActions
    @IBAction func setFallAsleepTime(_ sender: UISlider) {
        fallAsleepTimeLabel.text = "\(Int(sender.value)) min"
        viewModel.fallAsleepTime = sender.value
    }
    
    @IBAction func playStopRingtone(_ sender: Any) {
        isPlaying = !isPlaying
    }
    
    @IBAction func setVibrationState(_ sender: UISwitch) {
        viewModel.isVibrated = sender.isOn
    }
    
    @IBAction func setRingtoneVolume(_ sender: UISlider) {
        viewModel.alarmVolume = sender.value
    }
    
    @IBAction func tapCancelButton(_ sender: Any) {
        router?.routeToMain()
    }
    
    @IBAction func tapDoneButton(_ sender: Any) {
        if interactor?.settings != nil {
            interactor?.makeRequest(request: .updateSettings(settings: viewModel))
            router?.routeToMain()
        }
    }
}

extension NewSettingsViewController {
    //MARK: - UITableView Protocol
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 && indexPath.row == 0 {
            let snoozeVC = NewSnoozeViewController()
            snoozeVC.delegate = self
            snoozeVC.snoozeTime = viewModel.snoozeTime
            //FIXME: - to Router???
            self.show(snoozeVC, sender: self)
        } else if indexPath.section == 1 && indexPath.row == 0 {
            //FIXME: - to Router???
            self.present(mediaPicker, animated: true) {
                let defaults = UserDefaults.standard
                if !defaults.bool(forKey: "neverShow") {
                    let alert = self.createAttentionAlert()
                    self.mediaPicker.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

//MARK: - MPMediaPickerControllerDelegate
extension NewSettingsViewController: MPMediaPickerControllerDelegate {
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        guard let item = mediaItemCollection.items.first else {
            print("no item")
            return
        }
        print("picking id \(item.persistentID)")

        guard let url = item.assetURL else {
            print("no url")
            return
        }
        viewModel.ringtone = SettingsViewModel.Ringtone(artistName: item.artist ?? "",
                                                        ringtoneName: item.title ?? "",
                                                        persistentId: String(item.persistentID))
        
        engine.startEngine(playFileAt: url)
        ringtoneNameLabel.text = "\(item.artist ?? "") - \(item.title ?? "")"
        isPlaying = true
        
        //FIXME: - to Router???
        mediaPicker.dismiss(animated: true)
    }
    
    func getRingtoneWithPersistentId(_ id: String) -> MPMediaItem? {
        let predicate = MPMediaPropertyPredicate(value: id, forProperty: MPMediaItemPropertyPersistentID)
        let query = MPMediaQuery()
        query.addFilterPredicate(predicate)
        
        var ringtone: MPMediaItem?
        guard let items = query.items, items.count > 0 else { return nil }
        ringtone = items.first
        return ringtone
    }
}

extension NewSettingsViewController: NewSnoozeViewControllerDelegate {
    func passData(minutes: Int?) {
        if let snoozeTime = minutes {
            viewModel.snoozeTime = minutes
            snoozeTimeLabel.text = "\(snoozeTime) min"
        } else {
            viewModel.snoozeTime = nil
            snoozeTimeLabel.text = "Never"
        }
    }
}





//To use all apple music library, but it must use system mpplayer
//if item.persistentID != 0 {
//    let mp = MPMusicPlayerController.systemMusicPlayer
//    mp.setQueue(with: mediaItemCollection)
//    mp.prepareToPlay()
//    mp.play()
//    self.dismiss(animated: true, completion: nil)
//} else {
//    let alert = createSimpleAlert(title: "Error", message: "You can't use Apple's playlist. First, you must add it to your library")
//    self.mediaPicker.present(alert, animated: true, completion: nil)
//}
