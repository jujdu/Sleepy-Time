//
//  WakeUpTimeModels.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 22.11.2019.
//  Copyright (c) 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

enum WakeUpTime {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getWakeUpTime
            }
        }
        struct Response {
            enum ResponseType {
                case presentWakeUpTime(sleepyTime: SleepyTime, settings: Settings?)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayWakeUpTime(viewModel: WakeUpTimeViewModel)
            }
        }
    }
    
}

struct WakeUpTimeViewModel {
    struct Cell {
        var cyclesCount: Int
        var date: Date
    }
    
    let sleepyTime: SleepyTime
    var cells: [Cell]
}
