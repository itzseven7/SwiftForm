//
//  TextFieldTableViewCell.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit
import SwiftForm

final class TextFieldTableViewCell: UITableViewCell, TextFieldFormItemContainer {
  
  // MARK: - Outlets
  @IBOutlet private weak var ibStackView: UIStackView!
  @IBOutlet weak var ibTitleLabel: UILabel!
  @IBOutlet weak var ibDescriptionLabel: UILabel!
  @IBOutlet weak var ibTextField: UITextField!
  @IBOutlet weak var ibErrorLabel: UILabel!
  
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
  }
  
  private func configureView() {
    ibTitleLabel.isHidden = ibTitleLabel.text == nil
    ibDescriptionLabel.isHidden = ibDescriptionLabel.text == nil
    ibErrorLabel.isHidden = ibErrorLabel.text == nil
    
    let titleBottomSpacing = CGFloat(ibDescriptionLabel.isHidden ? 12 : 6)
    ibStackView.setCustomSpacing(titleBottomSpacing, after: ibTitleLabel)
    
    let descriptionBottomSpacing = CGFloat(ibDescriptionLabel.isHidden ? 0 : 6)
    ibStackView.setCustomSpacing(descriptionBottomSpacing, after: ibDescriptionLabel)
    
    let inputBottomSpacing = CGFloat(ibErrorLabel.isHidden ? 0 : 6)
    ibStackView.setCustomSpacing(inputBottomSpacing, after: ibTextField)
    
    configureStyles()
    
    if formItem?.isEditing ?? false && !ibErrorLabel.isHidden {
      ibErrorLabel.shake()
    }
  }
  
  private func configureStyles() {
    guard let item = formItem else { return }
    
    switch item.state {
    case .disabled:
      ibTitleLabel.textColor = UIColor.lightGray
    case .normal:
      ibTitleLabel.textColor = UIColor.blue
    case .editing:
      ibTitleLabel.textColor = UIColor.green
    case .error:
      ibTitleLabel.textColor = UIColor.red
    }
  }
  
//  @objc func cancelAction() {
//    textFieldFormItemViewModel?.textFieldDidCancelEditing(ibTextField)
//  }
//
//  @objc func doneAction() {
//    textFieldFormItemViewModel?.textFieldDidValidateEditing(ibTextField)
//  }
}

extension TextFieldTableViewCell {
  var input: UITextField {
    return ibTextField
  }
  
  var titleLabel: UILabel? {
    return ibTitleLabel
  }
  
  var descriptionLabel: UILabel? {
    return ibDescriptionLabel
  }
  
  var errorLabel: UILabel? {
    return ibErrorLabel
  }
  
  func finishSetUp() {
    configureView()
  }
  
  func onValidationEvent(formItem: FormItem) {
    bind()
    configureView()
  }
  
  func onActivationEvent(formItem: FormItem) {
    ibTextField.isUserInteractionEnabled = formItem.isEnabled
  }
  
  func onEditingEvent(formItem: FormItem) {
    configureStyles()
  }
}

extension TextFieldTableViewCell: UITextFieldDelegate {
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
