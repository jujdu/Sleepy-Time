//
//  TableViewController.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 12.12.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Settings"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.prefersLargeTitles = true
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}
