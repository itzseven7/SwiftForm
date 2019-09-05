//
//  ReminderTextFieldTableViewCell.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit
import SwiftForm

final class ReminderTextFieldTableViewCell: UITableViewCell, TextFieldFormItemContainer {
  @IBOutlet weak var ibTextField: UITextField!
  
  var formItem: FormItem?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    ibTextField.delegate = self
  }
}

extension ReminderTextFieldTableViewCell {
  var input: UITextField {
    return ibTextField
  }
  
  var titleLabel: UILabel? {
    return nil
  }
  
  var descriptionLabel: UILabel? {
    return nil
  }
  
  var errorLabel: UILabel? {
    return nil
  }
  
  func finishSetUp() {}
}

extension ReminderTextFieldTableViewCell: UITextFieldDelegate {
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    return textFieldFormItem?.textFieldShouldClear(textField) ?? true
  }
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    return textFieldFormItem?.textFieldShouldEndEditing(textField) ?? true
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    return textFieldFormItem?.textFieldShouldReturn(textField) ?? true
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    return textFieldFormItem?.textField(textField, shouldChangeCharactersIn: range, replacementString: string) ?? true
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    textFieldFormItem?.textFieldDidBeginEditing(textField)
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    textFieldFormItem?.textFieldDidEndEditing(textField)
  }
}
