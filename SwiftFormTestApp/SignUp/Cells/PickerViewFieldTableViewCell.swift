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
  @IBOutlet weak var ibTextField: UITextField!
  @IBOutlet weak var ibErrorLabel: UILabel!
  
  let picker = UIPickerView()
  
  var formItem: FormItem?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    ibTextField.delegate = self
    ibTextField.borderStyle = .none
    ibTitleLabel.textColor = UIColor.black
    ibErrorLabel.textColor = UIColor.red
    
    ibTitleLabel.preferredMaxLayoutWidth = ibTitleLabel.frame.width
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

extension PickerViewFieldTableViewCell: TextFieldFormItemContainerResponderAdapter {
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
    return nil
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
  
  func onEditingEvent(formItem: FormItem) {
    configureStyles()
  }
}
