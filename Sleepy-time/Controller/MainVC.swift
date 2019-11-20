//
//  MainVC.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 09/09/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

//class CustomUIView: UIView {
//    override var canBecomeFirstResponder: Bool {
//        return true
//    }
//}

class MainVC: UIViewController {
    
    @IBOutlet weak var wakeUpToTimeBtn: UIButton!
    @IBOutlet weak var wakeUpFromNowBtn: UIButton!
    @IBOutlet weak var pickTimeTxt: UITextField!
    
    //MARK: - Have to wake up views
    let haveToWakeUpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    //MARK: - DatePicker
    //    var datePicker: UIDatePicker = {
    //        let datePicker = UIDatePicker()
    //        datePicker.translatesAutoresizingMaskIntoConstraints = false
    //        datePicker.datePickerMode = .time
    //        datePicker.minuteInterval = 5
    //        datePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
    //       return datePicker
    //    }()
    
    
    let timeLabel: DatePickerLabel = {
        let dateDatePicker = UIDatePicker()
        dateDatePicker.translatesAutoresizingMaskIntoConstraints = false
        dateDatePicker.datePickerMode = .time
        dateDatePicker.minuteInterval = 5
        dateDatePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        
        let label = DatePickerLabel(datePickerView: dateDatePicker, toolbar: UIToolbar())
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.backgroundColor = .yellow
        label.numberOfLines = 1
        label.font = UIFont(name: "Futura", size: 35)
        label.placeholder = "-:-"
        return label
    }()
    
    let wakeUpToTimeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Calculate", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    //MARK: - OR View
    let orLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    //MARK: - Find ut when to get up Views
    let FindOutWhenLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    let wakeUpToTimeLabel: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("zzZ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    private var datePicker: UIDatePicker!
    
    var choosenTime: AlarmTime!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
        setupTapGestureToView()
        
        view.addSubview(timeLabel)
        timeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
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
    
    //MARK: - Gesture to listen datePicker changing
    @objc func dateChanged(datePicker: UIDatePicker) {
        let date = datePicker.date
        pickTimeTxt.text = convertedDateToString(date: date)
        choosenTime = AlarmTime(cycle: 0, date: date, needTimeToFallAsleep: nil, type: .toTime)
    }
    
    //MARK: - Tap Gesture to View to exit Picker View
    func setupTapGestureToView() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(viewTapped(gestureRecognazer:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped(gestureRecognazer: UITapGestureRecognizer) {
        view.endEditing(true)
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

//extension MainVC: UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        print(#function)
//        pickTimeTxt.isUserInteractionEnabled = false
//    }
//
//    //    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//    //        return true
//    //    }
//    //    func textFieldDidBeginEditing(_ textField: UITextField) {
//    //        textField.isEnabled = false
//    //    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        textField.isUserInteractionEnabled = true
//    }
//}

final class DatePickerLabel: UILabel {
    private let datePickerView: UIDatePicker
    private let toolbar: UIToolbar
    private var userTextColor: UIColor!
    private var userText: String!
    
    var placeholder: String? {
        willSet {
            self.userTextColor = self.textColor
            super.text = newValue
        }
    }
    
    override var text: String? {
        get {
            return "sadasdasd"
        }
        
        set {
            super.text = newValue
        }
    }
    
//    override var text: String? {
//        get {
//            if placeholder != nil {
//                self.textColor = .green
//                return placeholder
//            } else {
//                self.textColor = .red
//                return "self.text"
//            }
//        }
//        set {
//            placeholder = nil
//        }
//    }
        
//        didSet {
//            if placeholder != nil {
//                print("placeholder")
//                print(placeholder)
//
//                self.text = placeholder
//                textColor = .gray
//            } else {
//                print("userTextColor")
//
//                self.text = "abasdasdsaas"
//                textColor = userTextColor
//            }
//        }
//    }
    
    required init(datePickerView: UIDatePicker, toolbar: UIToolbar) {
        self.datePickerView = datePickerView
        self.toolbar = toolbar
        super.init(frame: .zero)
        
        self.isUserInteractionEnabled = true
        datePickerView.addTarget(self, action: #selector(valueChanged(datePicker:)), for: .valueChanged)
        
        let recogniser = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(recogniser)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override var inputView: UIView? {
        return datePickerView
    }
    
    override var inputAccessoryView: UIView? {
        return toolbar
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    @objc private func tapped() {
        becomeFirstResponder()
    }
    
    @objc private func valueChanged(datePicker: UIDatePicker) {
        let date = datePicker.date
        self.placeholder = nil
        self.text = convertedDateToString(date: date)
    }
}
