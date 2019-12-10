//
//  UITableViewHeaderFooterView+Extensions.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 06.12.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

extension UITableViewHeaderFooterView {
    convenience init(frame: CGRect, text: String?) {
        self.init()

        let headerView = UIView(frame: frame)
        let label = UILabel(frame: CGRect(x: 16,
                                          y: frame.height * 0.25,
                                          width: frame.width,
                                          height: frame.height * 0.5))

        self.addSubview(headerView)
        
        if let text = text {
            label.font = UIFont(name: AppFonts.avenirLight, size: 14)
            label.textColor = .lightGray
            label.text = text
    
            headerView.addSubview(label)
        }
    }
}


















// FOR PLAIN STYLE OF TABLE
//
//
//extension UITableViewHeaderFooterView {
//    convenience init(frame: CGRect, text: String?) {
//        self.init()
//        let backgroundView = UIView(frame: CGRect(x: 0,
//                                                  y: 0,
//                                                  width: frame.width,
//                                                  height: frame.height))
//        backgroundView.backgroundColor = .separator
//
//        let headerView = UIView(frame: CGRect(x: 0,
//                                              y: 0.15,
//                                              width: frame.width,
//                                              height: frame.height - 0.3))
//        let label = UILabel(frame: CGRect(x: 16,
//                                          y: frame.height * 0.25,
//                                          width: frame.width,
//                                          height: frame.height * 0.5))
//        headerView.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9490196078, blue: 0.9647058824, alpha: 1)
//
//        self.addSubview(headerView)
////        backgroundView.addSubview(headerView)
//
//        if let text = text {
//            label.font = UIFont(name: AppFonts.avenirLight, size: 14)
//            label.textColor = .lightGray
//            label.text = text
//
//            headerView.addSubview(label)
//        }
//    }
//}
