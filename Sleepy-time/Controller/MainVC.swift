//
//  MainVC.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 09/09/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    //MARK: - Stack View
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 12
        return stackView
    }()
    
    //MARK: - Have to wake up views
    let descriptionToTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "I have to wake up at..."
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Book", size: 17)
        label.numberOfLines = 1
        return label
    }()

    let toTimeLabel: DatePickerLabel = {
        let dateDatePicker = UIDatePicker()
        dateDatePicker.translatesAutoresizingMaskIntoConstraints = false
        dateDatePicker.datePickerMode = .time
        dateDatePicker.minuteInterval = 5
        
        let label = DatePickerLabel(datePickerView: dateDatePicker, toolbar: UIToolbar())
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Find out when to get up if you go to bed right now"
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont(name: "Avenir-Light", size: 35)
        label.placeholder = "pick time"
        return label
    }()
    
    let toTimeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Calculate", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 20)
        button.backgroundColor = .blue
        return button
    }()
    
    //MARK: - OR View
    let orLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "or"
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Book", size: 17)
        label.numberOfLines = 1
        return label
    }()
    
    //MARK: - Find ut when to get up Views
    let fromNowTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Find out when to get up if you go to bed right now"
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Book", size: 17)
        label.numberOfLines = 2
        return label
    }()
    
    let fromNowTimeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("zzZ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 20)
        button.backgroundColor = .blue
        return button
    }()
    
    //MARK: - Properties
    var choosenTime = AlarmTime(cycle: 5, date: Date(), needTimeToFallAsleep: nil, type: .toTime)
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupTapGestureForView()
        setupTapGestureForToTimeButton()
    }
    
    //MARK: - Constraints
    
    private func setupConstraints() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(descriptionToTimeLabel)
        stackView.addArrangedSubview(toTimeLabel)
        stackView.addArrangedSubview(toTimeButton)
        stackView.addArrangedSubview(orLabel)
        stackView.addArrangedSubview(fromNowTimeLabel)
        stackView.addArrangedSubview(fromNowTimeButton)
        
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        toTimeLabel.widthAnchor.constraint(greaterThanOrEqualTo: descriptionToTimeLabel.widthAnchor).isActive = true
        toTimeButton.widthAnchor.constraint(greaterThanOrEqualTo: descriptionToTimeLabel.widthAnchor).isActive = true
        fromNowTimeButton.widthAnchor.constraint(greaterThanOrEqualTo: descriptionToTimeLabel.widthAnchor).isActive = true
    }
    
    func setupTapGestureForToTimeButton() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(toTimeButtonTapped))
        toTimeButton.addGestureRecognizer(tapGesture)
    }
    
    @objc func toTimeButtonTapped() {
        if toTimeLabel.placeholder != nil {
            toTimeLabel.shake()
        } else {
//            let vc = ToTimeVC(choosenTime: choosenTime)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ToTimeVC") as! ToTimeVC
            vc.choosenTime = choosenTime
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //MARK: - Tap Gesture to View to exit Picker View
    func setupTapGestureForView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped() {
        view.endEditing(true)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == Segues.wakeUpToTime {
//            if let destination = segue.destination as? ToTimeVC {
//                destination.choosenTime = choosenTime
//            }
//        } else if segue.identifier == Segues.wakeUpFromNow {
//            if let destination = segue.destination as? FromNowVC {
//                destination.choosenTime = AlarmTime(cycle: 0, date: Date(), needTimeToFallAsleep: nil, type: .fromNow)
//            }
//        }
//    }
    
    @IBAction func unwindSegueToMainVC(_ sender: UIStoryboardSegue) {}
}
