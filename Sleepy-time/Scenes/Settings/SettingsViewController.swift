//
//  SettingsViewController.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 26.11.2019.
//  Copyright (c) 2019 Michael Sidoruk. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation
import CoreData

protocol SettingsDisplayLogic: class {
    func displayData(viewModel: Settings.Model.ViewModel.ViewModelData)
}

class SettingsViewController: UIViewController, SettingsDisplayLogic {
    
    //MARK: - Views
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: -10, left: 0, bottom: 0, right: 0)
        tableView.allowsSelection = true
        return tableView
    }()
    
    lazy var cancelBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelSettings))
        return barButtonItem
    }()
    
    lazy var doneBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveSettings))
        return barButtonItem
    }()
    
    //FIXME: - Need to decide what to do with dismiss, save anytime when settings is changed or save only after the save button is tapped
    @objc func saveSettings() {
        //MARK: - Добавление данных в CoreDate длинным путем
        do {
            try context.save()
            print("\n Update entity")
        } catch {
            print(error.localizedDescription)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelSettings() {
        //MARK: - Откат к настройкам до их изменения
        context.rollback()
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Properties
    var interactor: SettingsBusinessLogic?
    var router: (NSObjectProtocol & SettingsRoutingLogic & SettingsDataPassing)?
    
    private var viewModel = SettingsViewModel(items: [])
    private let mediaPicker = MPMediaPickerController.self(mediaTypes: .music)
    private let engine = AVAudioEngine()
    private let player = AVPlayer()
    private let avplayer = AVAudioPlayer()
    
    var context: NSManagedObjectContext! = (UIApplication.shared.delegate as! AppDelegate).coreDataStack.persistentContainer.viewContext
    var settings: SettingsDataBase!
    
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
        let interactor            = SettingsInteractor()
        let presenter             = SettingsPresenter()
        let router                = SettingsRouter()
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
        view.backgroundColor = .white
        
        //MARK: - получение данных из CoreDate
        let fetchRequest: NSFetchRequest<SettingsDataBase> = SettingsDataBase.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let count = try context.count(for: fetchRequest)
            if count == 0 {
                let entity = NSEntityDescription.entity(forEntityName: "SettingsDataBase", in: context)
                let taskObject = NSManagedObject(entity: entity!, insertInto: context) as! SettingsDataBase
                taskObject.snoozeTime = 15
                taskObject.fallAsleepTime = 24
                taskObject.ringtone = Data()
                taskObject.isVibrated = false
                taskObject.alarmVolume = 1
                try context.save()
                settings = taskObject
                print("\n Create entity")
                print(settings)
            } else {
                settings = try context.fetch(fetchRequest).first
                print("\n Read entity")
                print(settings)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        interactor?.makeRequest(request: .getSettings(settings: settings))
        
        setupConstraints()
//        interactor?.makeRequest(request: .getSettings)
        setupTableView()
        setupNavBar()
        setupMediaPicker()
        
    }
    
    func displayData(viewModel: Settings.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displaySettings(let viewModel):
            self.viewModel = viewModel
            tableView.reloadData()
        @unknown default:
            print("SettingsViewController has another response")
        }
    }
    
    //MARK: - Constraints
    private func setupConstraints() {
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = cancelBarButton
        navigationItem.rightBarButtonItem = doneBarButton
        navigationItem.title = "Settings"
    }
    
    //MARK: - UI Configure
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.items.forEach { $0.type.registerCell(tableView: tableView) }
    }
    
    private func setupMediaPicker() {
        mediaPicker.allowsPickingMultipleItems = false
        mediaPicker.showsCloudItems = false
        mediaPicker.showsItemsWithProtectedAssets = false
        mediaPicker.delegate = self
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
    
}

//MARK: - UITableView Protocols
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.items.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items[section].rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemType = viewModel.items[indexPath.section].type
        let cell = itemType.cellForSettingsItemType(tableView: tableView, indexPath: indexPath)
        itemType.configureCellForModelItemType(cell: cell, data: viewModel.items[indexPath.section], settings: settings)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let itemType = viewModel.items[indexPath.section].type
        
        switch itemType {
        case .snooze, .song:
            cell.selectionStyle = .default
        default:
            cell.selectionStyle = .none
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UITableViewHeaderFooterView(frame: CGRect(x: .zero,
                                                         y: .zero,
                                                         width: tableView.frame.width,
                                                         height: viewModel.items[section].sectionHeight),
                                           text: viewModel.items[section].sectionTitle)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.items[section].sectionHeight
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let itemType = viewModel.items[indexPath.section].type
        
        switch itemType {
        case .song:
            self.present(mediaPicker, animated: true) {
                let alert = self.createAttentionAlert()
                self.mediaPicker.present(alert, animated: true, completion: nil)
            }
        case .snooze:
            let snoozeVC = SnoozeViewController()
            self.show(snoozeVC, sender: self)
        default:
            print("Others types")
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}

//MARK: - MPMediaPickerControllerDelegate
extension SettingsViewController: MPMediaPickerControllerDelegate {
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

//MARK: - UINavigationBarDelegate
extension SettingsViewController: UINavigationBarDelegate {
    public func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
