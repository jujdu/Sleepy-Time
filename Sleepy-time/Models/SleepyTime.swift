//
//  SleepyTime.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 22.11.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import Foundation

struct SleepyTime {
    var choosenDate: Date
    var type: SleepyTimeType
}

enum SleepyTimeType {
    case toTime
    case fromNowTime
    
    func getDescription(from strDate: String) -> String {
        switch self {
        case .toTime:
            return "If you want to wake up at \(strDate), you should try to fall asleep at one of the following times:"
        case .fromNowTime:
            return "If you head to bed right now at \(strDate), you should try to wake up at one of the following times:"
        }
    }
}


