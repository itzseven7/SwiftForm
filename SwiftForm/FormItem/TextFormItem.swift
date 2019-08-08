//
//  TextFormItem.swift
//  CPA-ios
//
//  Copyright © 2019 itzseven7. All rights reserved.
//

import Foundation

protocol TextFormItemErrorProvider: FormItemErrorProvider {
  
  var emptyError: String? { get }
}

open class TextFormItem: BaseFormItem<String> {
  
  private var textErrorProvider: TextFormItemErrorProvider? {
    return errorProvider as? TextFormItemErrorProvider
  }
  
  override public func checkValidity() {
    super.checkValidity()
    
    guard let value = value, isValid ?? false else {
      return
    }
    
    let trimmedValue = value.trimmingCharacters(in: .whitespacesAndNewlines)
    
    isValid = !trimmedValue.isEmpty
    error = isValid ?? false ? nil : textErrorProvider?.emptyError
  }
}
