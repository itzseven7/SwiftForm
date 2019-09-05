//
//  EmailAddressValidator.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
import SwiftForm

final class EmailAddressValidator: RegularExpressionValidator {
  init(value: String? = nil) {
    super.init(value: value, patterns: ["^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"])
    
    errorProvider = self
  }
}

extension EmailAddressValidator: RegularExpressionValidatorErrorProvider {
  func unmatchedPatternsError(for patterns: [String]) -> String? {
    return "Your email address has an invalid format."
  }
  
  var emptyError: String? {
    return "Your email address can't be empty."
  }
  
  var noValueError: String? {
    return "You must specify an email address."
  }
}

final class EmailAddressFormItem: TextFieldInputFormItem<String> {
  override init(value: String? = nil) {
    super.init(value: value)
    
    title = "Email address"
    autocapitalizationType = .none
    autocorrectionType = .no
    keyboardType = .emailAddress
    returnKeyType = .next
    clearButtonMode = .whileEditing
    maximumCharacters = 254
  }
  
  override func validator(_ value: String?) -> ValueValidator<String> {
    return EmailAddressValidator(value: value)
  }
  
  override func value(from inputValue: String?) -> String? {
    return inputValue
  }
  
  override func inputValue(from value: String?) -> String? {
    return value
  }
}

extension EmailAddressFormItem: TableViewFormItem {
  var cellType: TableViewFormItemCellType {
    return CellType.textField
  }
}
