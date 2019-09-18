//
//  SettingsVC.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 09/09/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class SettingsVC: UITableViewController {
    
    @IBOutlet weak var minToRepeatLbl: UILabel!
    @IBOutlet weak var repeatSwitch: UISwitch!
    @IBOutlet weak var minToRepeatSlider: UISlider!
    
    let userDefaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        let minToRepeat = userDefaults.float(forKey: UserDefaultKeys.minToRepeatSlider)
        minToRepeatLbl.text = "\(Int(minToRepeat))"
        minToRepeatSlider.value = minToRepeat
        repeatSwitch.isOn = userDefaults.bool(forKey: UserDefaultKeys.repeatSwitch)
    }
    
    @IBAction func minToRepeatSliderChanged(_ sender: UISlider) {
        userDefaults.set(sender.value, forKey: UserDefaultKeys.minToRepeatSlider)
    }
    
    @IBAction func repeatSwitchChanged(_ sender: UISwitch) {
        userDefaults.set(sender.isOn, forKey: UserDefaultKeys.repeatSwitch)
    }
}

