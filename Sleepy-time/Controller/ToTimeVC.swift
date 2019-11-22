//
//  DetailVC.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 09/09/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class ToTimeVC: UIViewController {
    
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
    
    //MARK: - Properties
    var sleepyTime: SleepyTime!
    let userDefaults = UserDefaults()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = alarmBarButton
        setupConstraints()
        setupTableView()
        setupInfoLbl()
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
        tableView.register(ToTimeCycleCell.self, forCellReuseIdentifier: ToTimeCycleCell.reuseId)
        tableView.tableFooterView = UIView()
    }
    
    private func setupInfoLbl() {
        let date = sleepyTime.choosenDate.shortStyleString()
        infoLabel.text = "If you want to wake up at \(date), you should try to fall asleep at one of the following times:"
    }

}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ToTimeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sleepyTime.alarmTime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ToTimeCycleCell.reuseId, for: indexPath) as? ToTimeCycleCell {
            cell.setupUI(cycle: sleepyTime.alarmTime[indexPath.row])
            print(sleepyTime.alarmTime[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
