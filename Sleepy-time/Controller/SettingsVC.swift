//
//  SettingsVC.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 09/09/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class SettingsVC: UITableViewController {
    
    @IBOutlet weak var repeatLbl: UILabel!
    @IBOutlet weak var repeatSwitch: UISwitch!
    @IBOutlet weak var repeatSlider: UISlider!
    @IBOutlet weak var fallAsleepLbl: UILabel!
    @IBOutlet weak var fallAsleepSlider: UISlider!
    
    let userDefaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        setupSnoozeCell()
        setupFallAsleepCell()
    }
    
    func setupSnoozeCell() {
        repeatSlider.minimumValue = 1
        repeatSlider.maximumValue = 30
        let minToRepeat = userDefaults.float(forKey: UserDefaultKeys.repeatSlider)
        repeatLbl.text = "\(Int(minToRepeat)) min"
        repeatSlider.value = minToRepeat
        repeatSwitch.isOn = userDefaults.bool(forKey: UserDefaultKeys.repeatSwitch)
    }
    
    func setupFallAsleepCell() {
        fallAsleepSlider.minimumValue = 4
        fallAsleepSlider.maximumValue = 45
        let minToFallAsleep = userDefaults.float(forKey: UserDefaultKeys.fallAsleepSlider)
        fallAsleepLbl.text = "\(Int(minToFallAsleep)) min"
        fallAsleepSlider.value = minToFallAsleep
    }
    
    @IBAction func repeatSliderChanged(_ sender: UISlider) {
        userDefaults.set(sender.value, forKey: UserDefaultKeys.repeatSlider)
        let minToRepeat = userDefaults.float(forKey: UserDefaultKeys.repeatSlider)
        repeatLbl.text = "\(Int(minToRepeat)) min"
    }
    
    @IBAction func repeatSwitchChanged(_ sender: UISwitch) {
        userDefaults.set(sender.isOn, forKey: UserDefaultKeys.repeatSwitch)
        
    }
    
    @IBAction func fallAsleepChanged(_ sender: UISlider) {
        userDefaults.set(sender.value, forKey: UserDefaultKeys.fallAsleepSlider)
        let minToFallAsleep = userDefaults.float(forKey: UserDefaultKeys.fallAsleepSlider)
        fallAsleepLbl.text = "\(Int(minToFallAsleep)) min"
    }
    
}

