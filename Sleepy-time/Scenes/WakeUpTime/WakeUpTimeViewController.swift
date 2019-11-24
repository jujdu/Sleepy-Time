//
//  WakeUpTimeViewController.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 22.11.2019.
//  Copyright (c) 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol WakeUpTimeDisplayLogic: class {
    func displayData(viewModel: WakeUpTime.Model.ViewModel.ViewModelData)
}

class WakeUpTimeViewController: UIViewController, WakeUpTimeDisplayLogic {
    
    //MARK: - Bar buttons
    lazy var alarmBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.image = #imageLiteral(resourceName: "ic_add_alarm_36pt")
        return barButtonItem
    }()
    
    //MARK: - Info Label. Up side
    let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: AppFonts.avenirBook, size: 17)
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - Table View. Down side
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        return tableView
    }()
    
    // MARK: - Properties
    var interactor: WakeUpTimeBusinessLogic?
    var router: (NSObjectProtocol & WakeUpTimeRoutingLogic & WakeUpTimeDataPassing)?
    var sleepyTime: SleepyTime?
    
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
        let interactor            = WakeUpTimeInteractor()
        let presenter             = WakeUpTimePresenter()
        let router                = WakeUpTimeRouter()
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
        setupConstraints()
        setupTableView()
        setupNavigationBar()
        interactor?.makeRequest(request: .getWakeUpTime)
    }
    
    //MARK: - UI Configuration
    private func setupConstraints() {
        view.addSubview(infoLabel)
        view.addSubview(tableView)
        
        infoLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: tableView.topAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 12, bottom: 0, right: 12))
        tableView.anchor(top: infoLabel.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        infoLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WakeUpTimeCell.self, forCellReuseIdentifier: WakeUpTimeCell.reuseId)
        tableView.tableFooterView = UIView()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Alarm Time"
        if sleepyTime?.type == .toTime {
   
            self.navigationItem.rightBarButtonItem = alarmBarButton
        }
    }
    
    private func setupInfoLbl() {
        let date = sleepyTime?.choosenDate.shortStyleString() ?? ""
        if sleepyTime?.type == .toTime {
            infoLabel.text = "If you want to wake up at \(date), you should try to fall asleep at one of the following times:"
        } else {
            infoLabel.text = "If you head to bed right now at \(date), you should try to wake up at one of the following times:"
        }
    }
    
    func displayData(viewModel: WakeUpTime.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayWakeUpTime(let viewModel):
            sleepyTime = viewModel
            setupInfoLbl()
            setupNavigationBar()
            tableView.reloadData()
        @unknown default:
            print("WakeUpTimeViewController has another viewModel")
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension WakeUpTimeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sleepyTime?.alarmTimes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: WakeUpTimeCell.reuseId, for: indexPath) as? WakeUpTimeCell {
            guard let alarmTime = sleepyTime?.alarmTimes[indexPath.row],
                let type = sleepyTime?.type
                else { return UITableViewCell() }
            cell.setupUI(alarmTime: alarmTime, cellType: type)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
