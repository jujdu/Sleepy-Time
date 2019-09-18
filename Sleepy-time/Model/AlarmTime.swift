//
//  AlarmTime.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 09/09/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import Foundation

struct AlarmTime {
    var cycle: Int
    var date: Date
    var needTimeToFallAsleep: Int?
    var type: AlarmTimeType
}

enum AlarmTimeType {
    case toTime
    case fromNow
}
