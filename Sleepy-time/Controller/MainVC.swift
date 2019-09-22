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
    
    private var datePicker: UIDatePicker!
    
    var choosenTime: AlarmTime!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
        setupTapGestureToView()
    }
    
    func setupDatePicker() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .time
        datePicker?.minuteInterval = 5
        datePicker?.addTarget(self,
                              action: #selector(dateChanged(datePicker:)),
                              for: .valueChanged)
        
        pickTimeTxt.tintColor = UIColor.clear
        pickTimeTxt.inputView = datePicker
    }
    
    func setupTapGestureToView() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(viewTapped(gestureRecognazer:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped(gestureRecognazer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let date = datePicker.date
        
        pickTimeTxt.text = convertedDateToString(date: date)
        
        choosenTime = AlarmTime(cycle: 0, date: date, needTimeToFallAsleep: nil, type: .toTime)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.wakeUpToTime {
            if let destination = segue.destination as? ToTimeVC {
                destination.choosenTime = choosenTime
            }
        } else if segue.identifier == Segues.wakeUpFromNow {
            if let destination = segue.destination as? FromNowVC {
                destination.choosenTime = AlarmTime(cycle: 0, date: Date(), needTimeToFallAsleep: nil, type: .fromNow)
            }
        }
    }
    
    @IBAction func wakeUptoTimeBtnPressed(_ sender: Any) {
        if pickTimeTxt.text?.isEmpty ?? false {
            pickTimeTxt.shake()
        } else {
            performSegue(withIdentifier: Segues.wakeUpToTime, sender: self)
        }
    }
    
    @IBAction func unwindSegueToMainVC(_ sender: UIStoryboardSegue) {}
}
