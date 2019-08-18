//
//  TextValidator.swift
//  CPA-ios
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation

public protocol TextValidatorErrorProvider: ValueValidatorErrorProvider {
  
  var emptyError: String? { get }
}

open class TextValidator: ValueValidator<String> {
  
  private var textErrorProvider: TextValidatorErrorProvider? {
    return errorProvider as? TextValidatorErrorProvider
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
