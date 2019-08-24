//
//  PickerViewFieldTableViewCell.swift
//  CPA-ios
//
//  Copyright © 2018 Healsy. All rights reserved.
//

import UIKit
import SwiftForm

final class PickerViewFieldTableViewCell: UITableViewCell, PickerViewFormItemContainer {
  
  // MARK: - Outlets
  @IBOutlet private weak var ibStackView: UIStackView!
  @IBOutlet weak var ibTitleLabel: UILabel!
  @IBOutlet weak var ibDescriptionLabel: UILabel!
  @IBOutlet weak var ibTextField: UITextField!
  @IBOutlet weak var ibErrorLabel: UILabel!
  
  let picker = UIPickerView()
  
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
    
    picker.backgroundColor = .white
    picker.dataSource = self
    picker.delegate = self
    
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
}

extension PickerViewFieldTableViewCell: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return pickerViewFormItem?.numberOfComponents(in: pickerView) ?? 0
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerViewFormItem?.pickerView(pickerView, numberOfRowsInComponent: component) ?? 0
  }
}

extension PickerViewFieldTableViewCell: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    pickerViewFormItem?.pickerView(pickerView, didSelectRow: row, inComponent: component)
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return pickerViewFormItem?.pickerView(pickerView, titleForRow: row, forComponent: component)
  }
}

extension PickerViewFieldTableViewCell: TextFieldResponderFormItemContainer {
  var responder: UITextField {
    return ibTextField
  }
  
  var responderInputView: UIView {
    return picker
  }
}

extension PickerViewFieldTableViewCell: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    pickerViewFormItemWithTextField?.textFieldDidBeginEditing(textField)
    pickerViewFormItem?.pickerView(picker, didSelectRow: picker.selectedRow(inComponent: 0), inComponent: 0)
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    pickerViewFormItemWithTextField?.textFieldDidEndEditing(textField)
  }
}

extension PickerViewFieldTableViewCell {
  var titleLabel: UILabel? {
    return ibTitleLabel
  }
  
  var descriptionLabel: UILabel? {
    return ibDescriptionLabel
  }
  
  var errorLabel: UILabel? {
    return ibErrorLabel
  }
  
  var input: UIPickerView {
    return picker
  }
  
  func finishSetUp() {
    configureView()
  }
}
