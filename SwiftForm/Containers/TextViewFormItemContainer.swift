//
//  TextViewFormItemContainer.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

public protocol TextViewFormItemContainer: FormItemInputContainer {
  var input: UITextView { get }
}

extension TextViewFormItemContainer {
  public var textViewFormItem: TextViewFormItem? {
    return formItem as? TextViewFormItem
  }
}

extension TextViewFormItemContainer {
  public func setUp() {
    guard let formItem = formItem else { return } // at this stage whe should have a form item
    
    formItem.beginEditingCallback = { [weak self] in
      self?.input.becomeFirstResponder()
    }
    
    formItem.endEditingCallback = { [weak self] in
      self?.input.resignFirstResponder()
    }
    
    formItem.addObserver(self)
    
    bind()
    finishSetUp()
  }
  
  public func bind() {
    guard let textViewFormItem = textViewFormItem else { return }
    
    titleLabel?.text = textViewFormItem.title
    descriptionLabel?.text = textViewFormItem.description
    errorLabel?.text = textViewFormItem.error
    
    input.text = textViewFormItem.text
    input.isEditable = textViewFormItem.isEditable
  }
}
