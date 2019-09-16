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
    @IBOutlet weak var pickTimeTxt: UITextField!
    
    private var datePicker: UIDatePicker?
    
    var choosenTime: AlarmTime!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        pickTimeTxt.delegate = self
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .time
        datePicker?.minuteInterval = 5
        datePicker?.addTarget(self,
                              action: #selector(dateChanged(datePicker:)),
                              for: .valueChanged)
        pickTimeTxt.tintColor = UIColor.clear

        pickTimeTxt.inputView = datePicker
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognazer:)))
        view.addGestureRecognizer(tapGesture)
        
        wakeUpToTimeBtn.isEnabled = false
    }
    
    @objc func viewTapped(gestureRecognazer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = .current
        
        pickTimeTxt.text = dateFormatter.string(from: datePicker.date)
        choosenTime = AlarmTime(date: datePicker.date, type: .toTime)
        wakeUpToTimeBtn.isEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.wakeUpToTime {
            if let destination = segue.destination as? ToTimeVC {
                destination.choosenTime = choosenTime
            }
        } else if segue.identifier == Segues.wakeUpFromNow {
            if let destination = segue.destination as? FromNowVC {
                destination.choosenTime = AlarmTime(date: Date(), type: .fromNow)
            }
        }
    }
    
    @IBAction func wakeUptoTimeBtnPressed(_ sender: Any) {
//        add animate to textfield
    }
}

//extension MainVC: UITextFieldDelegate {
//
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        pickTimeTxt.isUserInteractionEnabled = false
//        return true
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
//        pickTimeTxt.isUserInteractionEnabled = true
//
//    }
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        return false
//    }
//}


//func calculateWakeUpTime(time: [AlarmTime]) -> [AlarmTime] {
//    var wakeUpTime = alarmTime
//    wakeUpTime.insert(AlarmTime(cycleIndex: 0, date: Date()), at: 0)
//    for i in 1..<6 {
//        let date = Date(timeInterval: 5400, since: wakeUpTime[i - 1].date)
//        wakeUpTime.insert(AlarmTime(cycleIndex: i, date: date), at: 0)
//    }
//    return wakeUpTime
//}
