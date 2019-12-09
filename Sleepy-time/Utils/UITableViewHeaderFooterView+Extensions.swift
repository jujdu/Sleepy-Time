//
//  UITableViewHeaderFooterView+Extensions.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 06.12.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

extension UITableViewHeaderFooterView {
    convenience init(width: CGFloat, height: CGFloat, text: String?) {
        self.init()
        if let text = text {
            let headerView = UIView(frame: CGRect(x: 0, y: 0.75, width: width, height: height - 1.5))
            let label = UILabel(frame: CGRect(x: 16, y: height * 0.25, width: width, height: height * 0.5))
            headerView.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9490196078, blue: 0.9647058824, alpha: 1)
            label.font = UIFont(name: AppFonts.avenirLight, size: 14)
            label.textColor = .lightGray
            label.text = text
            self.addSubview(headerView)
            headerView.addSubview(label)
        }
    }
}
