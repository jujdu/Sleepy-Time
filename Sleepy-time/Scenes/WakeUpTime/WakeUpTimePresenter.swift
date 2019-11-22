//
//  WakeUpTimePresenter.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 22.11.2019.
//  Copyright (c) 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol WakeUpTimePresentationLogic {
    func presentData(response: WakeUpTime.Model.Response.ResponseType)
}

class WakeUpTimePresenter: WakeUpTimePresentationLogic {
    
    weak var viewController: WakeUpTimeDisplayLogic?
    
    func presentData(response: WakeUpTime.Model.Response.ResponseType) {
        switch response {
        case .presentWakeUpTime(let viewModel):
            print("WakeUpTimePresenter .presentWakeUpTime")
            viewController?.displayData(viewModel: .displayWakeUpTime(viewModel: viewModel))
        @unknown default:
            print("WakeUpTimePresenter has another response")
        }
    }
}
