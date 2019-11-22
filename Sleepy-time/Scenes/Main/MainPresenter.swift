//
//  MainPresenter.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 22.11.2019.
//  Copyright (c) 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol MainPresentationLogic {
    func presentData(response: Main.Model.Response.ResponseType)
}

class MainPresenter: MainPresentationLogic {
    
    weak var viewController: MainDisplayLogic?
    
    func presentData(response: Main.Model.Response.ResponseType) {
        
    }
    
}
