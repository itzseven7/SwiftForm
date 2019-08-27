//
//  TextFieldInputFormItem.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

public protocol TextFieldFormItem: FormItem {
  
  var text: String? { get }
  
  var placeholder: String? { get }
  
  var isSecureTextEntry: Bool { get }
  
  var keyboardType: UIKeyboardType { get }
  
  var returnKeyType: UIReturnKeyType { get }
  
  var autocapitalizationType: UITextAutocapitalizationType { get }
  
  var autocorrectionType: UITextAutocorrectionType { get }
  
  var clearButtonMode: UITextField.ViewMode { get }
  
  var leftView: UIView? { get }
  
  var leftViewMode: UITextField.ViewMode { get }
  
  var rightView: UIView? { get }
  
  var rightViewMode: UITextField.ViewMode { get }
  
  var inputAccessoryView: UIView? { get }
  
  // UITextField original delegate must forward messages to the form item in order to work
  
  func textFieldDidBeginEditing(_ textField: UITextField)
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
  func textFieldDidEndEditing(_ textField: UITextField)
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
  func textFieldShouldClear(_ textField: UITextField) -> Bool
  func textFieldShouldReturn(_ textField: UITextField) -> Bool
}

public protocol TextFieldFormItemAdapter {
  var text: String? { get }
  
  var placeholder: String? { get }
  
  var leftViewMode: UITextField.ViewMode { get }
  
  var leftView: UIView? { get }
  
  var rightViewMode: UITextField.ViewMode { get }
  
  var rightView: UIView? { get }
  
  func textFieldDidBeginEditing(_ textField: UITextField)
  func textFieldDidEndEditing(_ textField: UITextField)
}

open class TextFieldInputFormItem<ValueType: Comparable>: TextFormItemInput<ValueType>, TextFieldFormItem {
  
  public var placeholder: String?
  
  public var isSecureTextEntry: Bool = false
  
  public var keyboardType: UIKeyboardType = .default
  
  public var returnKeyType: UIReturnKeyType = .default
  
  public var autocapitalizationType: UITextAutocapitalizationType = .sentences
  
  public var autocorrectionType: UITextAutocorrectionType = .default
  
  public var clearButtonMode: UITextField.ViewMode = .never
  
  public var leftView: UIView? { return nil }
  
  public var leftViewMode: UITextField.ViewMode { return .never }
  
  public var rightView: UIView? { return nil }
  
  public var rightViewMode: UITextField.ViewMode { return .never }
  
  public var inputAccessoryView: UIView? { return nil }
  
  var validationMode: ValidationMode = .always
  
  open func textFieldDidBeginEditing(_ textField: UITextField) {
    isEditing = true
    notifyEditingChange()
  }
  
  open func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    return validator.isValid ?? true
  }
  
  open func textFieldDidEndEditing(_ textField: UITextField) {
    isEditing = false
    notifyEditingChange()
  }
  
  open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let text = textField.text, let textRange = Range(range, in: text) else { return false }
    
    let updatedText = text.replacingCharacters(in: textRange, with: string)
    
    let currentInputText = unformatted(updatedText) ?? updatedText
    
    // Check length (doesn't take extra formatting text into account)
    guard maximumCharacters == -1 || currentInputText.count <= maximumCharacters else { return false }
    
    inputValue = currentInputText
    
    notifyTextChange()
    
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

extension TextFieldInputFormItem {
  public enum ValidationMode {
    case always // always validates the value when text field resigns first responder (textFieldDidEndEditing and textFieldShouldReturn)
    case onUserAction // only validates the value on textFieldShouldReturn
  }
}
