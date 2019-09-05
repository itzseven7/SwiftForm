//
//  ReminderTextViewTableViewCell.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit
import SwiftForm

final class ReminderTextViewTableViewCell: UITableViewCell, TextViewFormItemContainer {
  @IBOutlet weak var ibTitleLabel: UILabel!
  @IBOutlet weak var ibTextView: UITextView!
  
  var formItem: FormItem?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    ibTextView.delegate = self
  }
}

extension ReminderTextViewTableViewCell {
  var input: UITextView {
    return ibTextView
  }
  
  var titleLabel: UILabel? {
    return ibTitleLabel
  }
  
  var descriptionLabel: UILabel? {
    return nil
  }
  
  var errorLabel: UILabel? {
    return nil
  }
  
  func finishSetUp() {
    
  }
}

extension ReminderTextViewTableViewCell: UITextViewDelegate {
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
