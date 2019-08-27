//
//  TextViewTableViewCell.swift
//  CPA-ios
//
//  Copyright © 2018 Healsy. All rights reserved.
//

import UIKit
import SwiftForm

/// This class defines the text view cell
final class TextViewTableViewCell: UITableViewCell, TextViewFormItemContainer {
  
  // MARK: - Outlets
  @IBOutlet weak var ibTitleLabel: UILabel!
  @IBOutlet weak var ibStackView: UIStackView!
  @IBOutlet weak var ibDescriptionLabel: UILabel!
  @IBOutlet weak var ibTextView: UITextView!
  @IBOutlet weak var ibErrorLabel: UILabel!
  @IBOutlet weak var ibcTextViewHeight: NSLayoutConstraint!
  
  var formItem: FormItem?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    ibTextView.delegate = self
    ibTextView.layer.borderWidth = 0.5
    ibTextView.layer.borderColor = UIColor.gray.cgColor
    ibTextView.layer.cornerRadius = 9
    ibTextView.layer.masksToBounds = true
    ibTextView.textContainerInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    ibTextView.textContainer.lineFragmentPadding = 0
    ibTitleLabel.textColor = UIColor.blue
    ibDescriptionLabel.textColor = UIColor.lightGray
    ibErrorLabel.textColor = UIColor.red
  }
  
  /// Configures the view
  private func configureView() {
    let descriptionSpacing = CGFloat(ibDescriptionLabel.isHidden ? 12 : 6)
    ibStackView.setCustomSpacing(descriptionSpacing, after: ibTitleLabel)
    
    let bottomSpacing = CGFloat(ibErrorLabel.isHidden ? 0 : 12)
    ibStackView.setCustomSpacing(bottomSpacing, after: ibTextView)
  }
}

extension TextViewTableViewCell {
  var titleLabel: UILabel? {
    return ibTitleLabel
  }
  
  var descriptionLabel: UILabel? {
    return ibDescriptionLabel
  }
  
  var errorLabel: UILabel? {
    return ibErrorLabel
  }
  
  var input: UITextView {
    return ibTextView
  }
  
  func finishSetUp() {
    configureView()
  }
}

// MARK: - UITextFieldDelegate
extension TextViewTableViewCell: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    textViewFormItem?.textViewDidBeginEditing(textView)
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    textViewFormItem?.textViewDidEndEditing(textView)
  }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    return textViewFormItem?.textView(textView, shouldChangeTextIn: range, replacementText: text) ?? true
  }
}
