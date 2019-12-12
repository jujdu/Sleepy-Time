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
}