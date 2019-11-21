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
    
    //MARK: - To Time Views
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
        
        let label = DatePickerLabel(datePickerView: dateDatePicker)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Find out when to get up if you go to bed right now"
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont(name: "Avenir-Light", size: 35)
        label.placeholder = "pick time"
        return label
    }()
    
    let toTimeButton: RoundedButton = {
        let button = RoundedButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Calculate", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 20)
        button.backgroundColor = .cyan
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
    
    //MARK: - From Now Time Views
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
    
    let fromNowTimeButton: RoundedButton = {
        let button = RoundedButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let myMutableString = NSMutableAttributedString(string: "zzz", attributes: [NSAttributedString.Key.font: UIFont(name: "Avenir-Book", size: 16)!])
        myMutableString.addAttributes([NSAttributedString.Key.font: UIFont(name: "Avenir-Book", size: 20)!], range: NSRange(location: 1, length: 1))
        myMutableString.addAttributes([NSAttributedString.Key.font: UIFont(name: "Avenir-Book", size: 24)!], range: NSRange(location: 2, length: 1))
        button.setAttributedTitle(myMutableString, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        return button
    }()
    
    //MARK: - Properties
    var choosenTime: AlarmTime!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupTapGestureForView()
        setupTapGestureForToTimeButton()
        setupTapGestureForFromNowTimeButton()
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
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        toTimeLabel.widthAnchor.constraint(greaterThanOrEqualTo: descriptionToTimeLabel.widthAnchor).isActive = true
        toTimeButton.widthAnchor.constraint(greaterThanOrEqualTo: descriptionToTimeLabel.widthAnchor).isActive = true
        toTimeButton.heightAnchor.constraint(equalTo: fromNowTimeButton.heightAnchor).isActive = true
        fromNowTimeButton.widthAnchor.constraint(greaterThanOrEqualTo: descriptionToTimeLabel.widthAnchor).isActive = true
    }
    
    //MARK: - Gesture View
    func setupTapGestureForView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped() {
        view.endEditing(true)
    }
    
    //MARK: - Gesture toTimeButton
    func setupTapGestureForToTimeButton() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toTimeButtonTapped))
        toTimeButton.addGestureRecognizer(tapGesture)
    }
    
    @objc func toTimeButtonTapped() {
        guard toTimeLabel.placeholder == nil, let date = toTimeLabel.text?.customStyleDate() else {
            toTimeLabel.shake()
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ToTimeVC") as! ToTimeVC
        choosenTime = AlarmTime(cycle: 6, date: date, needTimeToFallAsleep: 0, type: .toTime)
        vc.choosenTime = choosenTime
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Gesture fromNowTimeButton
    func setupTapGestureForFromNowTimeButton() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fromNowTimeButtonTapped))
        fromNowTimeButton.addGestureRecognizer(tapGesture)
    }
    
    @objc func fromNowTimeButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FromNowTimeVC") as! FromNowVC
        let currentTime = AlarmTime(cycle: 6, date: Date(), needTimeToFallAsleep: 0, type: .fromNow)
        vc.choosenTime = currentTime
        navigationController?.pushViewController(vc, animated: true)
    }
}
