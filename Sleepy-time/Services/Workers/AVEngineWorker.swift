////
////  AVEngineWorker.swift
////  Sleepy-time
////
////  Created by Michael Sidoruk on 04.01.2020.
////  Copyright © 2020 Michael Sidoruk. All rights reserved.
////
//
//import UIKit
//import MediaPlayer
//
//class AVEngineWorker {
//
//    var engine: CustomAVAudioEngine?
//    lazy private var avEngineQueue: DispatchQueue = DispatchQueue(label: "avEngineQueue", qos: .userInitiated, attributes: .concurrent)
//
//    var userVolumeValue: Float!
//
//    private func playRingtone(_ value: Bool, viewModel: SettingsViewModel? = nil, block: @escaping (Float)->()) {
//        if value {
//            guard
//                let viewModel = viewModel,
//                let item = getRingtoneWithPersistentId(viewModel.ringtone.persistentId),
//                let url = item.assetURL else { return }
//
//            engine = CustomAVAudioEngine()
//            let semaphore = DispatchSemaphore(value: 1)
//
//            userVolumeValue = AVAudioSession.sharedInstance().outputVolume
//            DispatchQueue.main.async { //иначе setVolume не сработает первый раз
//                block(self.userVolumeValue)
//            }
//
//            avEngineQueue.async { [weak self] in
//                defer { semaphore.signal() }
//                semaphore.wait()
//                self?.engine?.startEngine(playFileAt: url)
//            }
//        } else {
//            block(userVolumeValue)
////            mpVolumeView.setVolume(userVolumeValue)
//            engine = nil //engine долго стартует в бэке, поэтому если быстро нажимать то он стартует при состоянии: пауза. Для этого обнуляю.
//        }
//    }
//
//    func getRingtoneWithPersistentId(_ id: String) -> MPMediaItem? {
//        let predicate = MPMediaPropertyPredicate(value: id, forProperty: MPMediaItemPropertyPersistentID)
//        let query = MPMediaQuery()
//        query.addFilterPredicate(predicate)
//
//        var ringtone: MPMediaItem?
//        guard let items = query.items, items.count > 0 else { return nil }
//        ringtone = items.first
//        return ringtone
//    }
//}
