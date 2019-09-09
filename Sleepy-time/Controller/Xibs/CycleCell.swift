//
//  CycleCell.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 09/09/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class CycleCell: UITableViewCell {

    @IBOutlet weak var cycleLbl: UILabel!
    @IBOutlet weak var hoursLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupUI(time: Date, index: Int) {
        cycleLbl.text = "Cycle \(index + 1)"
        hoursLbl.text = foundSleepyHours(index: index)
        timeLbl.text = getStringFromDate(time)
    }
    
    func foundSleepyHours(index: Int) -> String {
        let time = 1.5 * (Double(index) + 1)
        
        if floor(time) == time {
            return "\(Int(time)) sleepy hours"
        } else {
            return "\(time) sleepy hours"
        }
    }
    
    func getStringFromDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
