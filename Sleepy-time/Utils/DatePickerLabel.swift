//
//  DatePickerLabel.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 20.11.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

final class DatePickerLabel: UILabel {
    private let datePickerView: UIDatePicker
    private let toolbar: UIToolbar
    private var choosenTextColor: UIColor!
    private var userText: String!
    
    var placeholder: String? {
        willSet {
            super.text = newValue
        }
    }
    
    override var textColor: UIColor! {
        willSet {
            if placeholder == nil {
                choosenTextColor = newValue
            }
        }
    }
    
    override var text: String? {
        get {
            if let placeholder = placeholder {
                self.textColor = .gray
                return placeholder
            } else {
                self.textColor = choosenTextColor
                return super.text
            }
        }
        
        set {
            super.text = newValue
        }
    }
    
    required init(datePickerView: UIDatePicker, toolbar: UIToolbar) {
        self.datePickerView = datePickerView
        self.toolbar = toolbar
        super.init(frame: .zero)
        
        self.isUserInteractionEnabled = true
        datePickerView.addTarget(self, action: #selector(valueChanged(datePicker:)), for: .valueChanged)
        
        let recogniser = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(recogniser)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override var inputView: UIView? {
        return datePickerView
    }
    
    override var inputAccessoryView: UIView? {
        return toolbar
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    @objc private func tapped() {
        becomeFirstResponder()
    }
    
    @objc private func valueChanged(datePicker: UIDatePicker) {
        let date = datePicker.date
        self.placeholder = nil
        self.text = convertedDateToString(date: date)
    }
}