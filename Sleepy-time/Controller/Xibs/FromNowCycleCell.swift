//
//  CycleCell.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 09/09/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class FromNowCycleCell: UITableViewCell {

    @IBOutlet weak var cycleLbl: UILabel!
    @IBOutlet weak var hoursLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupUI(date: Date, index: Int) {
        cycleLbl.text = "Cycles: \(index + 1)"
        hoursLbl.text = foundSleepyHoursFromNow(index: index)
        timeLbl.text = date.shortStyleString()
    }
    
    func foundSleepyHoursFromNow(index: Int) -> String {
        let time = 1.5 * (Double(index) + 1)
        
        if floor(time) == time {
            return "\(Int(time)) sleepy hours"
        } else {
            return "\(time) sleepy hours"
        }
    }
}
