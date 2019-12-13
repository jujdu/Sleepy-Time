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
    @IBOutlet weak var ringtoneNameLabel: UILabel!
    @IBOutlet weak var ringtoneVibrationSwitch: UISwitch!
    @IBOutlet weak var ringtoneVolumeSlider: UISlider!
    
    // MARK: - Properties
    var interactor: NewSettingsBusinessLogic?
    var router: (NSObjectProtocol & NewSettingsRoutingLogic & NewSettingsDataPassing)?
    private let mediaPicker = MPMediaPickerController.self(mediaTypes: .music)
    private let engine = AVAudioEngine()
    private let player = AVPlayer()
    private let avplayer = AVAudioPlayer()
    
    var context: NSManagedObjectContext! = (UIApplication.shared.delegate as! AppDelegate).coreDataStack.persistentContainer.viewContext
    var settings: MySettings!
    var taskObject: SettingsDataBase!
    
    
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
    
    // MARK: - Routing
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let scene = segue.identifier {
//            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
//            if let router = router, router.responds(to: selector) {
//                router.perform(selector, with: segue)
//            }
//        }
//    }
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMediaPicker()
        setupNavigationBar()
        
        //MARK: - получение данных из CoreDate
        let fetchRequest: NSFetchRequest<SettingsDataBase> = SettingsDataBase.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let count = try context.count(for: fetchRequest)
            if count == 0 {
                let entity = NSEntityDescription.entity(forEntityName: "SettingsDataBase", in: context)
                self.taskObject = NSManagedObject(entity: entity!, insertInto: context) as? SettingsDataBase
                
                taskObject.snoozeTime = 5
                taskObject.fallAsleepTime = 14
                taskObject.ringtone = Data()
                taskObject.isVibrated = true
                taskObject.alarmVolume = 1
                try context.save()
                settings = taskObject.toMySettings()
                print("\n Create entity")
            } else {
                self.taskObject = try context.fetch(fetchRequest).first
                settings = self.taskObject?.toMySettings()
                print("\n Read entity")
            }
        } catch {
            print(error.localizedDescription)
        }
        
        
        interactor?.makeRequest(request: .getSettings(settings: taskObject))
    }

    func displayData(viewModel: NewSettings.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displaySettings(let viewModel):
            self.settings = viewModel.toMySettings()
            set(settings: settings)
        @unknown default:
            print("SettingsViewController has another response")
        }
    }
    
    func set(settings: MySettings) {
        guard let snoozeTime = settings.snoozeTime else {
            snoozeTimeLabel.text = "Never"
            return }
        
        snoozeTimeLabel.text = "\(snoozeTime) min"
        fallAsleepTimeLabel.text = String(settings.fallAsleepTime)
        fallAsleepSlider.value = Float(settings.fallAsleepTime)
        ringtoneNameLabel.text = "The Weeknd - Starboy"
        ringtoneVibrationSwitch.isOn = settings.isVibrated
        ringtoneVolumeSlider.value = Float(settings.alarmVolume)
    }
    
    private func setupMediaPicker() {
        mediaPicker.allowsPickingMultipleItems = false
        mediaPicker.showsCloudItems = false
        mediaPicker.showsItemsWithProtectedAssets = false
        mediaPicker.delegate = self
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Settings"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - AVEngine
    private func startEngine(playFileAt: URL) {
        engine.stop()
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)

            let avAudioFile = try AVAudioFile(forReading: playFileAt)
            let player = AVAudioPlayerNode()

            engine.attach(player)
            engine.connect(player, to: engine.mainMixerNode, format: avAudioFile.processingFormat)

            try engine.start()
            player.scheduleFile(avAudioFile, at: nil, completionHandler: nil)
            player.play()
        } catch {
            assertionFailure(String(describing: error))
        }
    }
    
    //MARK: - UITableView Protocol
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 && indexPath.row == 0 {
            let snoozeVC = NewSnoozeViewController()
            snoozeVC.delegate = self
            snoozeVC.snoozeTime = settings.snoozeTime
            self.show(snoozeVC, sender: self)
        } else if indexPath.section == 1 && indexPath.row == 0 {
            self.present(mediaPicker, animated: true) {
                let alert = self.createAttentionAlert()
                self.mediaPicker.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    //MARK: - @IBActions
    @IBAction func fallAsleepSliderChanged(_ sender: UISlider) {
        fallAsleepTimeLabel.text = String(Int16(sender.value))
        settings.fallAsleepTime = Int(sender.value)
    }
    
    @IBAction func ringtoneVibrationSwitchChanged(_ sender: UISwitch) {
        settings.isVibrated = sender.isOn
    }
    
    @IBAction func ringtoneVolumeSliderChanged(_ sender: UISlider) {
        settings.alarmVolume = Int(sender.value)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        //MARK: - Добавление данных в CoreDate длинным путем
        self.taskObject.fromMySettings(mySettings: settings)
        do {
            try context.save()
            print("\n Update entity")
        } catch {
            print(error.localizedDescription)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

//MARK: - MPMediaPickerControllerDelegate
extension NewSettingsViewController: MPMediaPickerControllerDelegate {
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        self.dismiss(animated: true, completion: nil)
        print("you picked: \(mediaItemCollection)")
        guard let item = mediaItemCollection.items.first else {
            print("no item")
            return
        }
        print("picking \(item.title!)")
        guard let url = item.assetURL else {
            return print("no url")
        }

        startEngine(playFileAt: url)
    }
}

extension NewSettingsViewController: NewSnoozeViewControllerDelegate {
    func passData(minutes: Int?) {
        guard let minutes = minutes else {
            settings.snoozeTime = nil
            snoozeTimeLabel.text = "Never"
            return
        }
        settings.snoozeTime = minutes
        snoozeTimeLabel.text = "\(minutes) min"
    }
}