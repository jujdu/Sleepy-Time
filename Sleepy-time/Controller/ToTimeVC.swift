//
//  DetailVC.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 09/09/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class ToTimeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoLbl: UILabel!
    
    var choosenTime: AlarmTime!
    var alarmTime: [Date]!
    let userDefaults = UserDefaults()
    
//    init(choosenTime: AlarmTime) {
//        self.choosenTime = choosenTime
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupInfoLbl()
        alarmTime = calculateWakeUpTime(choosenTime: choosenTime)
    }
    
    func setupInfoLbl() {
        let date = choosenTime.date.customStyleString()
        infoLbl.text = "If you want to wake up at \(date), you should try to fall asleep at one of the following times:"
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Xibs.toTimeCycleCell, bundle: nil),
                           forCellReuseIdentifier: Identifires.toTimeCycleCell)
    }
    
    func calculateWakeUpTime(choosenTime: AlarmTime) -> [Date] {
        let minToFallAsleep = userDefaults.double(forKey: UserDefaultKeys.fallAsleepSlider)
        var wakeUpTimeArray = [Date(timeInterval: -5400 - (minToFallAsleep * 60), since: choosenTime.date)]
        for i in 1..<6 {
            let date = Date(timeInterval: -5400, since: wakeUpTimeArray[i - 1])
            wakeUpTimeArray.insert(date, at: i)
        }
        return wakeUpTimeArray.reversed()
    }
}

extension ToTimeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmTime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifires.toTimeCycleCell, for: indexPath) as? ToTimeCycleCell {
//            cell.setupUI(time: alarmTime[indexPath.row], index: indexPath.row)
//            return cell
//        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
