//
//  MainViewController.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 22.11.2019.
//  Copyright (c) 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol MainDisplayLogic: class {
    func displayData(viewModel: Main.Model.ViewModel.ViewModelData)
}

class MainViewController: UIViewController, MainDisplayLogic {
    
    //MARK: - Bar buttons
    lazy var settingsBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_settings_36pt"), style: .plain, target: self, action: #selector(self.settingsBarButtonTapped))
        return barButtonItem
    }()
    
    lazy var infoBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_info_36pt"), style: .plain, target: self, action: #selector(self.infoBarButtonTapped))
        return barButtonItem
    }()
    
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
        label.font = UIFont(name: AppFonts.avenirBook, size: 17)
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
        label.font = UIFont(name: AppFonts.avenirLight, size: 35)
        label.placeholder = "_ : _"
        return label
    }()
    
    let toTimeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Calculate", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: AppFonts.avenirBook, size: 18)
        button.backgroundColor = .cyan
        button.layer.cornerRadius = 5
        return button
    }()
    
    //MARK: - OR View
    let orLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "or"
        label.textAlignment = .center
        label.font = UIFont(name: AppFonts.avenirBook, size: 17)
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
        label.font = UIFont(name: AppFonts.avenirBook, size: 17)
        label.numberOfLines = 2
        return label
    }()
    
    let fromNowTimeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let myMutableString = NSMutableAttributedString(string: "ZZZ",
                                                        attributes: [NSAttributedString.Key.font: UIFont(name: AppFonts.avenirBook, size: 12)!,
                                                                     NSAttributedString.Key.foregroundColor: UIColor.black])
        myMutableString.addAttributes([NSAttributedString.Key.font: UIFont(name: AppFonts.avenirBook, size: 15)!],
                                      range: NSRange(location: 1, length: 1))
        myMutableString.addAttributes([NSAttributedString.Key.font: UIFont(name: AppFonts.avenirBook, size: 18)!],
                                      range: NSRange(location: 2, length: 1))
        button.setAttributedTitle(myMutableString, for: .normal)
        button.backgroundColor = .cyan
        button.layer.cornerRadius = 5
        return button
    }()
    
    // MARK: - Properties
    var interactor: MainBusinessLogic?
    var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?
    var sleepyTime: SleepyTime!
    var choosenTime: Date!
    
    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        let viewController        = self
        let interactor            = MainInteractor()
        let presenter             = MainPresenter()
        let router                = MainRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
        router.dataStore          = interactor
    }
    
    // MARK: - Routing
    
    
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        toTimeLabel.delegate = self
        setupNavigationBar()
        setupConstraints()
        setupTapGestureForView()
        setupTapGestureForToTimeButton()
        setupTapGestureForFromNowTimeButton()
    }
    
    func displayData(viewModel: Main.Model.ViewModel.ViewModelData) {
        
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Sleepy Time"
        self.navigationItem.leftBarButtonItem = settingsBarButton
        self.navigationItem.rightBarButtonItem = infoBarButton
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
        toTimeButton.heightAnchor.constraint(equalToConstant: Constraints.buttonHeight).isActive = true
        fromNowTimeButton.widthAnchor.constraint(greaterThanOrEqualTo: descriptionToTimeLabel.widthAnchor).isActive = true
        fromNowTimeButton.heightAnchor.constraint(equalToConstant: Constraints.buttonHeight).isActive = true
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
        if toTimeLabel.placeholder == nil {
            interactor?.makeRequest(request: .setWakeUpTime(date: choosenTime,
                                                            alarmTimeType: .toTime))
            router?.routeToWakeUpTime()
        } else {
            toTimeLabel.shake()
        }
    }
    
    //MARK: - Gesture fromNowTimeButton
    func setupTapGestureForFromNowTimeButton() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fromNowTimeButtonTapped))
        fromNowTimeButton.addGestureRecognizer(tapGesture)
    }
    
    @objc func fromNowTimeButtonTapped() {
        interactor?.makeRequest(request: .setWakeUpTime(date: Date(),
                                                        alarmTimeType: .fromNowTime))
        router?.routeToWakeUpTime()
    }
    
    //MARK: - Gesture settingsBarButton
    @objc func settingsBarButtonTapped() {
        router?.routeToSettings()
    }
    
    @objc func infoBarButtonTapped() {
        print(#function)
        let pageVC = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageVC.modalPresentationStyle = .overFullScreen
        present(pageVC, animated: true, completion: nil)
    }
    
}

extension MainViewController: DatePickerLabelDelegate {
    func dateDidReceived(date: Date) {
        choosenTime = date
    }
}
