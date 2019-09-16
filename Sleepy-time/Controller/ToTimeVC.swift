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
    
    var choosenTime: AlarmTime!
    var alarmTime: [Date]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Xibs.cycleCell, bundle: nil),
                           forCellReuseIdentifier: Identifires.cycleCell)
        alarmTime = calculateWakeUpTime(choosenTime: choosenTime)
    }
    
    func calculateWakeUpTime(choosenTime: AlarmTime) -> [Date] {
        var wakeUpTimeArray = [Date(timeInterval: -5400, since: choosenTime.date)]
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifires.cycleCell, for: indexPath) as? ToTimeCycleCell {
            cell.setupUI(time: alarmTime[indexPath.row], index: indexPath.row)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
