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
  @IBOutlet weak var ibDescriptionLabel: UILabel!
  @IBOutlet weak var ibTextField: UITextField!
  @IBOutlet weak var ibErrorLabel: UILabel!
  
  let datePicker = UIDatePicker()
  
  var formItem: FormItem?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    ibTextField.delegate = self
    ibTextField.borderStyle = .line
    ibTextField.layer.borderWidth = 0.5
    ibTextField.layer.borderColor = UIColor.gray.cgColor
    ibTextField.layer.cornerRadius = 9
    ibTextField.layer.masksToBounds = true
    ibTitleLabel.textColor = UIColor.blue
    ibDescriptionLabel.textColor = UIColor.lightGray
    ibErrorLabel.textColor = UIColor.red
    
    ibTitleLabel.preferredMaxLayoutWidth = ibTitleLabel.frame.width
    ibDescriptionLabel.preferredMaxLayoutWidth = ibDescriptionLabel.frame.width
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
    ibDescriptionLabel.isHidden = ibDescriptionLabel.text == nil
    ibErrorLabel.isHidden = ibErrorLabel.text == nil
    
    let descriptionSpacing = CGFloat(ibDescriptionLabel.isHidden ? 12 : 6)
    ibStackView.setCustomSpacing(descriptionSpacing, after: ibTitleLabel)
    
    let bottomSpacing = CGFloat(ibErrorLabel.isHidden ? 0 : 12)
    ibStackView.setCustomSpacing(bottomSpacing, after: ibTextField)
  }
  
  @objc
  private func dateChanged(_ sender: UIDatePicker) {
    datePickerFormItem?.datePickerValueChanged(datePicker)
    //datePickerInputFormItem?.datePicker(sender, didChangeDateFromTextField: ibTextField)
  }
}

extension DatePickerFieldTableViewCell: TextFieldResponderFormItemContainer {
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
    return ibDescriptionLabel
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
}
