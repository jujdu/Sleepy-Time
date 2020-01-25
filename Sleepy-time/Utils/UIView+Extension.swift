//
//  UIView+Extension.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 22/09/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

extension UIView {
    func shake(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
}
