//
//  DatePickerLabel.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 20.11.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol UIDatePickerLabelDelegate {
    func didReceived(date: Date)
}

final class UIDatePickerLabel: UILabel {
    private let datePickerView: UIDatePicker
    private let toolbar: UIToolbar
    private var choosenTextColor: UIColor!
    private var userText: String!
    
    var delegate: UIDatePickerLabelDelegate!
    
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
                self.textColor = .placeholderText
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
    
    required init(datePickerView: UIDatePicker, toolbar: UIToolbar = UIToolbar()) {
        self.datePickerView = datePickerView
        self.toolbar = toolbar
        super.init(frame: .zero)
        
        self.isUserInteractionEnabled = true
        
        let recogniser = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(recogniser)
        
        datePickerView.addTarget(self, action: #selector(valueChanged(datePicker:)), for: .valueChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override var inputView: UIView? {
        return datePickerView
    }
    
    override var inputAccessoryView: UIView? {
        return toolbar
    }
    
    @objc private func tapped() {
        becomeFirstResponder()
    }
    
    @objc private func valueChanged(datePicker: UIDatePicker) {
        let date = datePicker.date
        self.placeholder = nil
        super.text = customStyleString(for: date)
        delegate.didReceived(date: date)
    }
    
    private func customStyleString(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
}
