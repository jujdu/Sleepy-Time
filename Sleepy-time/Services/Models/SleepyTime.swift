//
//  SleepyTime.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 22.11.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import Foundation

struct SleepyTime {
    var alarmTimes: [AlarmTime]
    var type: AlarmTimeType
    var choosenDate: Date
}

struct AlarmTime {
    var cyclesCount: Int
    var date: Date
}

enum AlarmTimeType {
    case toTime
    case fromNowTime
}
