//
//  DatePickerFieldTableViewCell.swift
//  CPA-ios
//
//  Copyright © 2018 Healsy. All rights reserved.
//

import UIKit
import SwiftForm

final class DatePickerFieldTableViewCell: UITableViewCell, DatePickerFormItemContainer {
  
  // MARK: - Outlets
  @IBOutlet private weak var ibStackView: UIStackView!
  @IBOutlet weak var ibTitleLabel: UILabel!
  @IBOutlet weak var ibTextField: UITextField!
  @IBOutlet weak var ibErrorLabel: UILabel!
  
  let datePicker = UIDatePicker()
  
  var formItem: FormItem?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    ibTextField.delegate = self
    ibTextField.borderStyle = .none
    ibTitleLabel.textColor = UIColor.black
    ibErrorLabel.textColor = UIColor.red
    
    ibTitleLabel.preferredMaxLayoutWidth = ibTitleLabel.frame.width
    ibErrorLabel.preferredMaxLayoutWidth = ibErrorLabel.frame.width
    
    datePicker.backgroundColor = .white
    datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    
    let toolBar: DefaultToolbar = UIView.fromNib()
    ibTextField.inputAccessoryView = toolBar
    
    toolBar.setTitle(nil)
    
    toolBar.ibLeftButton.setTitle("Cancel", for: .normal)
    toolBar.leftButtonActionCallback = { [weak self] in
      self?.formItem?.endEditing()
    }
    
    toolBar.ibRightButton.setTitle("Done", for: .normal)
    toolBar.rightButtonActionCallback = { [weak self] in
      self?.formItem?.validate()
    }
  }
  
  private func configureView() {
    ibTitleLabel.isHidden = ibTitleLabel.text == nil
    ibErrorLabel.isHidden = ibErrorLabel.text == nil
    
    let bottomSpacing = CGFloat(ibErrorLabel.isHidden ? 0 : 12)
    ibStackView.setCustomSpacing(bottomSpacing, after: ibTextField)
  }
  
  private func configureStyles() {
    guard let item = formItem else { return }
    
    switch item.state {
    case .disabled:
      ibTitleLabel.textColor = UIColor.lightGray
    case .normal:
      ibTitleLabel.textColor = UIColor.black
    case .editing:
      ibTitleLabel.textColor = UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1)
    case .error:
      ibTitleLabel.textColor = UIColor.red
    }
  }
  
  @objc
  private func dateChanged(_ sender: UIDatePicker) {
    datePickerFormItem?.datePickerValueChanged(datePicker)
  }
}

extension DatePickerFieldTableViewCell: TextFieldFormItemContainerResponderAdapter {
  var responder: UITextField {
    return ibTextField
  }
  
  var responderInputView: UIView {
    return datePicker
  }
}

extension DatePickerFieldTableViewCell: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    datePickerFormItemWithTextField?.textFieldDidBeginEditing(textField)
    datePickerFormItem?.datePickerValueChanged(datePicker)
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    datePickerFormItemWithTextField?.textFieldDidEndEditing(textField)
  }
}

extension DatePickerFieldTableViewCell {
  var titleLabel: UILabel? {
    return ibTitleLabel
  }
  
  var descriptionLabel: UILabel? {
    return nil
  }
  
  var errorLabel: UILabel? {
    return ibErrorLabel
  }
  
  var input: UIDatePicker {
    return datePicker
  }
  
  func finishSetUp() {
    configureView()
  }
  
  func onEditingEvent(formItem: FormItem) {
    configureStyles()
  }
}
