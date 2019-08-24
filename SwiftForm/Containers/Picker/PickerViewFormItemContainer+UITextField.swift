//
//  PickerViewFormItemContainer+UITextField.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

extension PickerViewFormItemContainer where Self: TextFieldResponderFormItemContainer {
  
  public var pickerViewFormItemWithTextField: TextFieldFormItemAdapter? {
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
    guard let pickerViewFormItem = pickerViewFormItem else { return }
    
    titleLabel?.text = pickerViewFormItem.title
    descriptionLabel?.text = pickerViewFormItem.description
    errorLabel?.text = pickerViewFormItem.error
    
    guard let pickerViewFormItemWithTextField = pickerViewFormItemWithTextField else { return }
    
    responder.text = pickerViewFormItemWithTextField.text
    responder.placeholder = pickerViewFormItemWithTextField.placeholder
    responder.leftViewMode = pickerViewFormItemWithTextField.leftViewMode
    responder.leftView = pickerViewFormItemWithTextField.leftView
    responder.rightViewMode = pickerViewFormItemWithTextField.rightViewMode
    responder.rightView = pickerViewFormItemWithTextField.rightView
    
    responder.inputView = responderInputView
  }
}
