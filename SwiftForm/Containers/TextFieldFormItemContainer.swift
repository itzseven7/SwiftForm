//
//  TextFieldFormItemContainer.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

public protocol TextFieldFormItemContainer: FormItemInputContainer {
  var input: UITextField { get }
}

extension TextFieldFormItemContainer {
  public var textFieldFormItem: TextFieldFormItem? {
    return formItem as? TextFieldFormItem
  }
}

extension TextFieldFormItemContainer {
  public func setUp() {
    formItem?.beginEditingCallback = { [weak self] in
      self?.input.becomeFirstResponder()
    }
    
    formItem?.endEditingCallback = { [weak self] in
      self?.input.resignFirstResponder()
    }
    
    formItem?.addObserver(self)
    
    bind()
    finishSetUp()
  }
  
  public func bind() {
    guard let textFieldFormItem = textFieldFormItem else { return }
    
    titleLabel?.text = textFieldFormItem.title
    descriptionLabel?.text = textFieldFormItem.description
    errorLabel?.text = textFieldFormItem.error
    
    input.text = textFieldFormItem.text
    input.placeholder = textFieldFormItem.placeholder
    input.isEnabled = textFieldFormItem.isEnabled
    //textField.attributedPlaceholder = textFieldFormItemViewModel.attributedPlaceholder
    
    input.isSecureTextEntry = textFieldFormItem.isSecureTextEntry
    input.keyboardType = textFieldFormItem.keyboardType
    input.returnKeyType = textFieldFormItem.returnKeyType
    input.autocapitalizationType = textFieldFormItem.autocapitalizationType
    input.autocorrectionType = textFieldFormItem.autocorrectionType
    input.leftView = textFieldFormItem.leftView
    input.leftViewMode = textFieldFormItem.leftViewMode
    input.rightView = textFieldFormItem.rightView
    input.rightViewMode = textFieldFormItem.rightViewMode
    input.inputAccessoryView = textFieldFormItem.inputAccessoryView
    input.clearButtonMode = textFieldFormItem.clearButtonMode
  }
}
