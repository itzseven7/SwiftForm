//
//  TextViewFormItem.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

public protocol TextViewFormItem: TextFormItem {
  var text: String? { get }
  
  var isEditable: Bool { get }
  
  // UITextView original delegate must forward messages to the form item in order to work
  
  func textViewShouldEndEditing(_ textView: UITextView) -> Bool
  func textViewDidBeginEditing(_ textView: UITextView)
  func textViewDidEndEditing(_ textView: UITextView)
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
}

open class TextViewInputFormItem: TextFormItemInput<String>, TextViewFormItem {
  public var isEditable: Bool = true
  
  public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
    return validator.isValid ?? true
  }
  
  public func textViewDidBeginEditing(_ textView: UITextView) {
    isEditing = true
    notifyEditingChange()
  }
  
  public func textViewDidEndEditing(_ textView: UITextView) {
    isEditing = false
    notifyEditingChange()
  }
  
  public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    guard let currentText = textView.text, let textRange = Range(range, in: currentText) else { return false }
    
    let updatedText = currentText.replacingCharacters(in: textRange, with: text)
    
    let currentInputText = unformatted(updatedText) ?? updatedText
    
    // Check length (doesn't take extra formatting text into account)
    guard maximumCharacters == -1 || currentInputText.count <= maximumCharacters else { return false }
    
    inputValue = currentInputText
    
    notifyTextChange()
    
    // If form item has a specific format to apply to text
    if let formattedText = formatted(currentInputText) {
      textView.text = formattedText
      return false
    }
    
    return true
  }
}
