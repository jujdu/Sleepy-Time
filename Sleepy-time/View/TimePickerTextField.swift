//
//  TimePickerTextField.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 16/09/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

/// This text field can be used for UIDatePicker and UIPickerView.
/// It has Select/Paste menu disabled, as well as zoom functionality and blinking cursor
open class TimePickerTextField: UITextField {
    
    /**
     Disables a magnifying glass for the text field.
     - note: http://stackoverflow.com/questions/10640781/disable-magnifying-glass-in-uitextview
     - parameter gestureRecognizer: A gesture recognizer.
     */
    override open func addGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer is UILongPressGestureRecognizer {
            gestureRecognizer.isEnabled = false
        }
        super.addGestureRecognizer(gestureRecognizer)
    }
    
    /**
     Disables copy/cut/paste/select all menu.
     - note: http://stackoverflow.com/questions/1426731/how-disable-copy-cut-select-select-all-in-uitextview
     - parameter action: A selector.
     - parameter sender: A sender.
     - returns: canPerformAction.
     */
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
    /// Turns out this is more efficient for hiding a blinking cursor than setting `tintColor` to .clear.
    /// Setting `tintColor` doesn't work when `UITextField.appearance().tintColor` is set.
    open override func caretRect(for position: UITextPosition) -> CGRect {
        return .zero
    }
    
}
