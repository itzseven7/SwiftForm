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
  
  var textContentType: UITextContentType? { get }
  
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

open class TextFieldInputFormItem<ValueType: Equatable>: TextFormItemInput<ValueType>, TextFieldFormItem {
  
  public var placeholder: String?
  
  public var isSecureTextEntry: Bool = false
  
  public var keyboardType: UIKeyboardType = .default
  
  public var returnKeyType: UIReturnKeyType = .default
  
  public var autocapitalizationType: UITextAutocapitalizationType = .sentences
  
  public var autocorrectionType: UITextAutocorrectionType = .default
  
  public var textContentType: UITextContentType?
  
  public var clearButtonMode: UITextField.ViewMode = .never
  
  public var leftView: UIView?
  
  public var leftViewMode: UITextField.ViewMode = .never
  
  public var rightView: UIView?
  
  public var rightViewMode: UITextField.ViewMode = .never
  
  public var inputAccessoryView: UIView?
  
  public var validationMode: ValidationMode = .returnKey
  
  var userDidReturn = false
  
  open func textFieldDidBeginEditing(_ textField: UITextField) {
    isEditing = true
    notifyEditingChange()
  }
  
  open func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    guard validationMode == .always else {
      return true
    }
    
    inputValue = unformatted(textField.text) ?? textField.text
    validate()
    return validator.isValid ?? true
  }
  
  open func textFieldDidEndEditing(_ textField: UITextField) {
    guard validationMode == .always, !userDidReturn else {
      userDidReturn = false
      isEditing = false
      notifyEditingChange()
      return
    }
    
    automaticallyFocusOnNextItem = false
    
    inputValue = textField.text
    validate()
    
    automaticallyFocusOnNextItem = true
    
    if validator.isValid ?? false {
      isEditing = false
      notifyEditingChange()
    }
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
    userDidReturn = true
    
    inputValue = unformatted(textField.text) ?? textField.text
    validate()
    
    if validator.isValid ?? true {
      return true
    } else {
      userDidReturn = false
      return false
    }
  }
}

extension TextFieldInputFormItem {
  public enum ValidationMode {
    case always // always validates the value when text field resigns first responder (textFieldDidEndEditing and textFieldShouldReturn)
    case returnKey // only validates the value on textFieldShouldReturn
  }
  
  public enum UnfocusReason {
    case returnKey // user click on next/done on keyboard
    case system // text field resigns first responder because of system (table view reload data, drag to dismiss...)
    case custom(shouldValidate: Bool)
    
    var shouldValidate: Bool {
      switch self {
      case .returnKey:
        return false
      case .system:
        <#code#>
      case .custom(let shouldValidate):
        <#code#>
      @unknown default:
        <#code#>
      }
    }
  }
}
