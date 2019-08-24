//
//  DatePickerFormItemContainer+UITextField.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

extension DatePickerFormItemContainer where Self: TextFieldResponderFormItemContainer {
  
  public var datePickerFormItemWithTextField: TextFieldFormItemAdapter? {
    return formItem as? TextFieldFormItemAdapter
  }
  
  public func setUp() {
    formItem?.beginEditingCallback = { [weak self] in
      self?.responder.becomeFirstResponder()
    }
    
    formItem?.endEditingCallback = { [weak self] in
      self?.responder.resignFirstResponder()
    }
    
    formItem?.addObserver(self)
    
    bind()
    finishSetUp()
  }
  
  public func bind() {
    guard let datePickerFormItem = datePickerFormItem else { return }
    
    titleLabel?.text = datePickerFormItem.title
    descriptionLabel?.text = datePickerFormItem.description
    errorLabel?.text = datePickerFormItem.error
    
    input.datePickerMode = datePickerFormItem.datePickerMode
    input.minimumDate = datePickerFormItem.minimumDate
    input.maximumDate = datePickerFormItem.maximumDate
    input.isEnabled = datePickerFormItem.isEnabled
    input.timeZone = datePickerFormItem.timeZone
    
    if let timeZone = datePickerFormItem.timeZone {
      input.calendar.timeZone = timeZone
    }
    
    if let date = datePickerFormItem.date {
      input.setDate(date, animated: true)
    }
    
    guard let datePickerFormItemWithTextField = datePickerFormItemWithTextField else { return }
    
    responder.text = datePickerFormItemWithTextField.text
    responder.placeholder = datePickerFormItemWithTextField.placeholder
    responder.leftViewMode = datePickerFormItemWithTextField.leftViewMode
    responder.leftView = datePickerFormItemWithTextField.leftView
    responder.rightViewMode = datePickerFormItemWithTextField.rightViewMode
    responder.rightView = datePickerFormItemWithTextField.rightView
    
    responder.inputView = responderInputView
  }
}
