//
//  SettingsViewController.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 09/09/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

class SettingsViewController: UIViewController, MPMediaPickerControllerDelegate {
    
    //MARK: - Views
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.isScrollEnabled = false
        tableView.allowsSelection = true
        return tableView
    }()
    
    lazy var cancelBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(abc))
        return barButtonItem
    }()
    
    lazy var doneBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(abc))
        return barButtonItem
    }()
    
    
    @objc func abc() {
        dismiss(animated: true, completion: nil)
    }
    
    lazy var navigationBar: UINavigationBar = {
        let screenSize: CGRect = UIScreen.main.bounds
        let navigationBar = UINavigationBar(frame: .zero)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.setBackgroundImage(nil, for:.default)
        navigationBar.shadowImage = nil
        navigationBar.isTranslucent = true
        navigationBar.delegate = self
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont(name: AppFonts.avenirHeavy, size: 18)!
        ]
        let standaloneItem = UINavigationItem()
        standaloneItem.leftBarButtonItem = cancelBarButton
        standaloneItem.rightBarButtonItem = doneBarButton
        standaloneItem.title = "Settings"
        navigationBar.items = [standaloneItem]
        return navigationBar
    }()
    
    //MARK: - Properties
    let userDefaults = UserDefaults.standard
    let mediaPicker = MPMediaPickerController.self(mediaTypes: .music)
    let mediaPlayer = MPMusicPlayerController.applicationMusicPlayer
    let engine = AVAudioEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TimeToFallAsleepCell.self, forCellReuseIdentifier: TimeToFallAsleepCell.reuseId)
        tableView.register(SnoozeCell.self, forCellReuseIdentifier: SnoozeCell.reuseId)
        tableView.register(SongCell.self, forCellReuseIdentifier: SongCell.reuseId)
        //        setupUI()
        setupConstraints()
        mediaPicker.allowsPickingMultipleItems = false
        mediaPicker.showsCloudItems = false
        mediaPicker.showsItemsWithProtectedAssets = false
        mediaPicker.delegate = self
        mediaPicker.prompt = "Pick a track"
    }
    
    func setupConstraints() {
        view.addSubview(tableView)
        view.addSubview(navigationBar)
        navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.anchor(top: navigationBar.bottomAnchor,
                         leading: view.leadingAnchor,
                         bottom: view.bottomAnchor,
                         trailing: view.trailingAnchor)
    }
    
    func startEngine(playFileAt: URL) {
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

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SnoozeCell.reuseId, for: indexPath) as? SnoozeCell {
                return cell
            }
            return UITableViewCell()
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TimeToFallAsleepCell.reuseId, for: indexPath) as? TimeToFallAsleepCell {
                return cell
            }
            return UITableViewCell()
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SongCell.reuseId, for: indexPath) as? SongCell {
                return cell
            }
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 2 {
            print("Go")
            self.present(mediaPicker, animated: true) {
                let alert = UIAlertController(title: "Attention", message: "Unfortunately, the application cannot support iCloud Media Library and Apple Music because of copyright issues 😢. However, you still have possibility to upload your own music to iTunes throught Music App.\nThank's for your understanding.\n🙏", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                let neverShow = UIAlertAction(title: "Never show", style: .cancel, handler: nil)
                alert.addAction(ok)
                alert.addAction(neverShow)
                self.mediaPicker.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        self.dismiss(animated: true, completion: nil)
        print("you picked: \(mediaItemCollection)")
//        mediaPlayer.setQueue(with: mediaItemCollection)
//        mediaPlayer.play()
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

extension SettingsViewController: UINavigationBarDelegate {
    public func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

