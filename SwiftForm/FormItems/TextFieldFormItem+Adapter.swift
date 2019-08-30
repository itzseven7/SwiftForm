//
//  TextFieldFormItem+Adapter.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

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
