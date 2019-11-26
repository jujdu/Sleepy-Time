////
////  SettingsViewController.swift
////  Sleepy-time
////
////  Created by Michael Sidoruk on 09/09/2019.
////  Copyright © 2019 Michael Sidoruk. All rights reserved.
////
//
//import UIKit
//import MediaPlayer
//import AVFoundation
//
//class SettingsViewControllerOld: UIViewController, MPMediaPickerControllerDelegate {
//    
//    //MARK: - Views
//    let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        tableView.isScrollEnabled = false
//        tableView.allowsSelection = true
//        return tableView
//    }()
//    
//    lazy var cancelBarButton: UIBarButtonItem = {
//        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(abc))
//        return barButtonItem
//    }()
//    
//    lazy var doneBarButton: UIBarButtonItem = {
//        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(abc))
//        return barButtonItem
//    }()
//    
//    //FIXME: - Need to decide what to do with dismiss, save anytime when settings is changed or save only after the save button is tapped
//    @objc func abc() {
//        dismiss(animated: true, completion: nil)
//    }
//    
//    lazy var navigationBar: UINavigationBar = {
//        let screenSize: CGRect = UIScreen.main.bounds
//        let navigationBar = UINavigationBar(frame: .zero)
//        navigationBar.translatesAutoresizingMaskIntoConstraints = false
//        navigationBar.setBackgroundImage(nil, for:.default)
//        navigationBar.shadowImage = nil
//        navigationBar.isTranslucent = true
//        navigationBar.delegate = self
//        navigationBar.titleTextAttributes = [
//            NSAttributedString.Key.foregroundColor: UIColor.black,
//            NSAttributedString.Key.font: UIFont(name: AppFonts.avenirHeavy, size: 18)!
//        ]
//        let standaloneItem = UINavigationItem()
//        standaloneItem.leftBarButtonItem = cancelBarButton
//        standaloneItem.rightBarButtonItem = doneBarButton
//        standaloneItem.title = "Settings"
//        navigationBar.items = [standaloneItem]
//        return navigationBar
//    }()
//    
//    //MARK: - Properties
//    let userDefaults = UserDefaults.standard
//    let mediaPicker = MPMediaPickerController.self(mediaTypes: .music)
//    let mediaPlayer = MPMusicPlayerController.applicationMusicPlayer
//    let engine = AVAudioEngine()
//    let player = AVPlayer()
//    let avplayer = AVAudioPlayer()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(TimeToFallAsleepCell.self, forCellReuseIdentifier: TimeToFallAsleepCell.reuseId)
//        tableView.register(SnoozeCell.self, forCellReuseIdentifier: SnoozeCell.reuseId)
//        tableView.register(SongCell.self, forCellReuseIdentifier: SongCell.reuseId)
//        //        setupUI()
//        setupConstraints()
//        mediaPicker.allowsPickingMultipleItems = false
//        mediaPicker.showsCloudItems = false
//        mediaPicker.showsItemsWithProtectedAssets = false
//        mediaPicker.delegate = self
//    }
//    
//    func setupConstraints() {
//        view.addSubview(tableView)
//        view.addSubview(navigationBar)
//        navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        tableView.anchor(top: navigationBar.bottomAnchor,
//                         leading: view.leadingAnchor,
//                         bottom: view.bottomAnchor,
//                         trailing: view.trailingAnchor)
//    }
//    
//    func startEngine(playFileAt: URL) {
//        engine.stop()
//        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback)
//
//            let avAudioFile = try AVAudioFile(forReading: playFileAt)
//            let player = AVAudioPlayerNode()
//
//            engine.attach(player)
//            engine.connect(player, to: engine.mainMixerNode, format: avAudioFile.processingFormat)
//
//            try engine.start()
//            player.scheduleFile(avAudioFile, at: nil, completionHandler: nil)
//            player.play()
//        } catch {
//            assertionFailure(String(describing: error))
//        }
//    }
//}
//
//
//
//
//
//
//
////func startEngine(playFileAt: URL) {
////    let playerItem = AVPlayerItem(url: playFileAt)
////    player.replaceCurrentItem(with: playerItem)
////    player.play()
//
