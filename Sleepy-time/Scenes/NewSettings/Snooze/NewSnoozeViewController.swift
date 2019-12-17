//
//  NewSnoozeViewController.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 13.12.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol NewSnoozeViewControllerDelegate: class {
    func passData(minutes: Int?)
}

class NewSnoozeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = true
        return tableView
    }()
    
//    var closure: ((Int?) -> ())? callback
    weak var delegate: NewSnoozeViewControllerDelegate?
    var snoozeTime: Int!
    private var index: Int!
    private let minutesArray = [nil, 1, 3, 5, 10, 15, 20, 25, 30, 45, 60]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        setupConstraints()
        index = { return minutesArray.firstIndex(of: snoozeTime) }()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    private func setupConstraints() {
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return minutesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        if indexPath.row == index {
            cell.accessoryType = .checkmark
        }
        
        if let min = minutesArray[indexPath.row] {
            cell.textLabel?.text = "\(min) min"
        } else {
            cell.textLabel?.text = "Never"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.cellForRow(at: IndexPath(row: index, section: 0))?.accessoryType = .none
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        index = indexPath.row
//        self.closure?(minutesArray[index])
        delegate?.passData(minutes: minutesArray[index])
    }
}
