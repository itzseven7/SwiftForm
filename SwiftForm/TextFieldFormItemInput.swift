//
//  TextFieldFormItemInput.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

public protocol TextFieldFormItemObserver: FormItemObserver {
  func onTextChangedEvent(formItem: TextFieldFormItem)
}

public protocol TextFieldFormItem {
  
  var isSecureTextEntry: Bool { get }
  
  var keyboardType: UIKeyboardType { get }
  
  var returnKeyType: UIReturnKeyType { get }
  
  var autocapitalizationType: UITextAutocapitalizationType { get }
  
  var autocorrectionType: UITextAutocorrectionType { get }
  
  var textAlignment: NSTextAlignment { get }
  
  var clearButtonMode: UITextField.ViewMode { get }
  
  var leftView: UIView? { get }
  
  var leftViewMode: UITextField.ViewMode { get }
  
  var rightView: UIView? { get }
  
  var rightViewMode: UITextField.ViewMode { get }
  
  func textFieldDidBeginEditing(_ textField: UITextField)
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
  func textFieldDidEndEditing(_ textField: UITextField)
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
  func textFieldShouldClear(_ textField: UITextField) -> Bool
  func textFieldShouldReturn(_ textField: UITextField) -> Bool
}

extension TextFieldFormItem {
  public var isSecureTextEntry: Bool {
    return false
  }
  
  public var keyboardType: UIKeyboardType {
    return .default
  }
  
  public var returnKeyType: UIReturnKeyType {
    return .default
  }
  
  public var autocapitalizationType: UITextAutocapitalizationType {
    return .sentences
  }
  
  public var autocorrectionType: UITextAutocorrectionType {
    return .default
  }
  
  public var textAlignment: NSTextAlignment {
    return .left
  }
  
  public var clearButtonMode: UITextField.ViewMode { return .never }
  
  public var leftView: UIView? { return nil }
  
  public var leftViewMode: UITextField.ViewMode { return .never }
  
  public var rightView: UIView? { return nil }
  
  public var rightViewMode: UITextField.ViewMode { return .never }
}

open class TextFieldFormItemInput<ValueType: Comparable>: TextFormItemInput<ValueType>, TextFieldFormItem {
  
  var validationMode: ValidationMode = .always
  
  open override func validate() {
    let text = (inputValue == nil) || (inputValue?.isEmpty ?? true) ? nil : inputValue
    base.validate(self.value(from: text))
  }
  
  open func textFieldDidBeginEditing(_ textField: UITextField) {
    isEditing = true
    notify { [weak self] observer in
      guard let sSelf = self else { return }
      observer.onEditingEvent(formItem: sSelf)
    }
  }
  
  open func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    return validator.isValid ?? true
  }
  
  open func textFieldDidEndEditing(_ textField: UITextField) {
    isEditing = false
    notify { [weak self] observer in
      guard let sSelf = self else { return }
      observer.onEditingEvent(formItem: sSelf)
    }
  }
  
  open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let text = textField.text, let textRange = Range(range, in: text) else { return false }
    
    let updatedText = text.replacingCharacters(in: textRange, with: string)
    
    let currentInputText = unformatted(updatedText) ?? updatedText
    
    // Check length (doesn't take extra formatting text into account)
    guard maximumCharacters == -1 || currentInputText.count <= maximumCharacters else { return false }
    
    inputValue = currentInputText
    
    // TODO: Not pretty
    notify { [weak self] observer in
      guard let sSelf = self else { return }
      (observer as? TextFieldFormItemObserver)?.onTextChangedEvent(formItem: sSelf)
    }
    
    // If form item has a specific format to apply to text
    if let formattedText = formatted(currentInputText) {
      textField.text = formattedText
      return false
    }
    
    return true
  }
  
  open func textFieldShouldClear(_ textField: UITextField) -> Bool {
    guard clearButtonMode != .never else { return true }
    
    inputValue = nil
    textField.text = nil
    
    return false
  }
  
  open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    inputValue = unformatted(textField.text) ?? textField.text
    
    validate()
    
    return true
  }
}

extension TextFieldFormItemInput {
  public enum ValidationMode {
    case always // always validates the value when text field resigns first responder (textFieldDidEndEditing and textFieldShouldReturn)
    case onUserAction // only validates the value on textFieldShouldReturn
  }
}
