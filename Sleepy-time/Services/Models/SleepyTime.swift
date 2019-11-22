//
//  SleepyTime.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 22.11.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import Foundation

struct SleepyTime {
    var alarmTime: [AlarmTime]
    var type: AlarmTimeType
    var choosenDate: Date
}

struct AlarmTime {
    var cycles: Int
    var date: Date
    var stringDate: String
}

enum AlarmTimeType {
    case toTime
    case fromNowTime
}
