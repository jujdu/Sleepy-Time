//
//  Date+Extension.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 19/09/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import Foundation

extension Date {
    public func customStyleString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }


    public func shortStyleString() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}

extension String {
    public func customStyleDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = .current
        return dateFormatter.date(from: self) ?? Date()
    }
}
