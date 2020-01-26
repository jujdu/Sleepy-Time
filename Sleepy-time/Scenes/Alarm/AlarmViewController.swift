//
//  AlarmViewController.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 09.01.2020.
//  Copyright © 2020 Michael Sidoruk. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController {
    
    let stopButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Stop", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(handleStopButton), for: .touchUpInside)
        return button
    }()
    
    @objc func handleStopButton() {
        AVAudioEngineWorker.shared.stopRingtone()

//        avWorker.stopRingtone()
//        self.dismiss(animated: true)
    }

    let avWorker = AVAudioEngineWorker.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        view.addSubview(stopButton)
        
        stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stopButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
//        avWorker.stopRingtone()
        AVAudioEngineWorker.shared.stopRingtone()
    }

}
