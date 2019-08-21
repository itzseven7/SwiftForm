//
//  FormTextFieldTableViewCell.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit
import SwiftForm

final class FormTextFieldTableViewCell: UITableViewCell, TextFieldFormItemContainer {
  
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
//    ibTextField.style = DefaultTextFieldStyle.input
//    ibTextField.backgroundColor = ColorName.greyLight.color
//    ibTextField.font = FontPreset.inputText.fontPurpose.font
//    ibTextField.textColor = ColorName.mainDefault.color
    ibTextField.borderStyle = .line
    ibTextField.layer.borderWidth = 0.5
    ibTextField.layer.borderColor = UIColor.gray.cgColor
    ibTextField.layer.cornerRadius = 9
    ibTextField.layer.masksToBounds = true
//    ibTextField.canPerformAction = false
//    ibTextField.textRectInsets = UIRendering.textFieldPadding
//    ibTextField.placeholderRectInsets = UIRendering.textFieldPadding
//    ibTextField.editingRectInsets = UIRendering.textFieldPadding
    
    ibTitleLabel.textColor = UIColor.blue
    ibDescriptionLabel.textColor = UIColor.lightGray
    ibErrorLabel.textColor = UIColor.red
    
    ibTitleLabel.preferredMaxLayoutWidth = ibTitleLabel.frame.width
    ibDescriptionLabel.preferredMaxLayoutWidth = ibDescriptionLabel.frame.width
    ibErrorLabel.preferredMaxLayoutWidth = ibErrorLabel.frame.width
  }
  
  private func configureView() {
    ibTitleLabel.text = formItem?.title
    ibTitleLabel.isHidden = ibTitleLabel.text == nil
    ibDescriptionLabel.text = formItem?.description
    ibDescriptionLabel.isHidden = ibDescriptionLabel.text == nil
    ibErrorLabel.text = formItem?.error
    ibErrorLabel.isHidden = ibErrorLabel.text == nil
    
    let titleBottomSpacing = CGFloat(ibDescriptionLabel.isHidden ? 12 : 6)
    ibStackView.setCustomSpacing(titleBottomSpacing, after: ibTitleLabel)
    
    let descriptionBottomSpacing = CGFloat(ibDescriptionLabel.isHidden ? 0 : 6)
    ibStackView.setCustomSpacing(descriptionBottomSpacing, after: ibDescriptionLabel)
    
    let inputBottomSpacing = CGFloat(ibErrorLabel.isHidden ? 0 : 6)
    ibStackView.setCustomSpacing(inputBottomSpacing, after: ibTextField)
    
    if formItem?.isEditing ?? false && !ibErrorLabel.isHidden {
      ibErrorLabel.shake()
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

extension FormTextFieldTableViewCell {
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
  
  var priority: Int {
    return 1
  }
  
  func onContainerBinding(formItem: FormItem) {
    configureView()
  }
  
  func onValidationEvent(formItem: FormItem) {
    configureView()
  }
  
  func onActivationEvent(formItem: FormItem) {
    
  }
  
  func onEditingEvent(formItem: FormItem) {
    if formItem.isEditing {
      ibTitleLabel.textColor = UIColor.green
    } else {
      ibTitleLabel.textColor = UIColor.blue
    }
  }
  
  func onVisibilityEvent(formItem: FormItem) {
    
  }
}

extension FormTextFieldTableViewCell: UITextFieldDelegate {
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
