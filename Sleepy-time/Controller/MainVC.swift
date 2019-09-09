//
//  MainVC.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 09/09/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var wakeUpToTimeBtn: UIButton!
    @IBOutlet weak var wakeUpFromNowBtn: UIButton!
    
    var alarmTime = [Date]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func calculateWakeUpTime(time: Date) -> [Date] {
        var wakeUpTime = [time]
        for i in 1..<6 {
            let date = Date(timeInterval: 5400, since: wakeUpTime[i - 1])
            wakeUpTime.insert(date, at: i)
        }
        return wakeUpTime
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailVC {
            if segue.identifier == Segues.wakeUpToTime {
                destination.alarmTime = calculateWakeUpTime(time: Date())
            } else {
                destination.alarmTime = calculateWakeUpTime(time: Date())
            }
        }
    }
    
    @IBAction func wakeUptoTimeBtnPressed(_ sender: Any) {
//        alarmTime = calculateWakeUpTime(time: Date())
    }
    
    @IBAction func wakeUpFromNowBtnPressed(_ sender: Any) {
//        alarmTime = calculateWakeUpTime(time: Date())
    }
}

//func calculateWakeUpTime(time: [AlarmTime]) -> [AlarmTime] {
//    var wakeUpTime = alarmTime
//    wakeUpTime.insert(AlarmTime(cycleIndex: 0, date: Date()), at: 0)
//    for i in 1..<6 {
//        let date = Date(timeInterval: 5400, since: wakeUpTime[i - 1].date)
//        wakeUpTime.insert(AlarmTime(cycleIndex: i, date: date), at: 0)
//    }
//    return wakeUpTime
//}
