//
//  TextFieldFormItem+Adapter.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

public protocol TextFieldResponderAdapter {
  var text: String? { get }
  
  var placeholder: String? { get }
  
  var leftViewMode: UITextField.ViewMode { get }
  
  var leftView: UIView? { get }
  
  var rightViewMode: UITextField.ViewMode { get }
  
  var rightView: UIView? { get }
  
  func textFieldDidBeginEditing(_ textField: UITextField)
  func textFieldDidEndEditing(_ textField: UITextField)
}

extension TextFieldResponderAdapter {
  public var leftViewMode: UITextField.ViewMode {
    return .never
  }
  
  public var leftView: UIView? {
    return nil
  }
  
  public var rightViewMode: UITextField.ViewMode {
    return .never
  }
  
  public var rightView: UIView? {
    return nil
  }
}

extension TextFieldResponderAdapter where Self: FormItem {
  public func textFieldDidBeginEditing(_ textField: UITextField) {
    isEditing = true
  }
  
  public func textFieldDidEndEditing(_ textField: UITextField) {
    isEditing = false
  }
}
