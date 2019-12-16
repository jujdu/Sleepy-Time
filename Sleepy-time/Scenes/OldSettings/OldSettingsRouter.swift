//
//  OldSettingsRouter.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 26.11.2019.
//  Copyright (c) 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol OldSettingsRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol OldSettingsDataPassing {
    var dataStore: OldSettingsDataStore? { get }
}

class OldSettingsRouter: NSObject, OldSettingsRoutingLogic, OldSettingsDataPassing {
    
    weak var viewController: OldSettingsViewController?
    var dataStore: OldSettingsDataStore?
    
    
    // MARK: - Routing
    // NOTE: Teach the router how to navigate to another scene. Some examples follow:
    
    // 1. Trigger a storyboard segue
    // viewController.performSegueWithIdentifier("ShowSomewhereScene", sender: nil)
    
    // 2. Present another view controller programmatically
    // viewController.presentViewController(someWhereViewController, animated: true, completion: nil)
    // viewController.show(viewController2, sender: Any?)
    
    // 3. Ask the navigation controller to push another view controller onto the stack
    // viewController.navigationController?.pushViewController(someWhereViewController, animated: true)
    
    // 4. Present a view controller from a different storyboard
    // let storyboard = UIStoryboard(name: "OtherThanMain", bundle: nil)
    // let someWhereViewController = storyboard.instantiateInitialViewController() as! SomeWhereViewController
    // viewController.navigationController?.pushViewController(someWhereViewController, animated: true)
    
//    func routeToSomewhere(segue: UIStoryboardSegue?) {
//      if let segue = segue {
//
//        // routing by segues
//        let destinationVC = segue.destination as! SomewhereViewController
//        var destinationDS = destinationVC.router!.dataStore!
//        passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//      } else {
//
//        // routing programmatically with storyboard
// //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
// //        let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
//
//        // routing progrommatically without storyboard
// //        let destinationVC = DestinationVC()
// //        var destinationDS = destinationVC.router!.dataStore!
// //        navigateToSomewhere(source: viewController!, destination: destinationVC)
// //        passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//      }
//    }
    
    // MARK: - Navigation
    
    //func navigateToSomewhere(source: SettingsViewController, destination: SomewhereViewController) {
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: - Passing data
    
    //func passDataToSomewhere(source: SettingsDataStore, destination: inout SomewhereDataStore) {
    //  destination.name = source.name
    //}
    
}
