//
//  SupportFile.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 19/09/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import Foundation

public func convertedDateToString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "h:mm a"
    dateFormatter.timeZone = .current
    
    return dateFormatter.string(from: date)
}


public func getStringFromDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return formatter.string(from: date)
}
