//
//  MainModels.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 22.11.2019.
//  Copyright (c) 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

enum Main {
    
    enum Model {
        struct Request {
            enum RequestType {
                case setWakeUpTime(sleepyTime: SleepyTime)
            }
        }
        struct Response {
            enum ResponseType {
                case some
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case some
            }
        }
    }
    
}
