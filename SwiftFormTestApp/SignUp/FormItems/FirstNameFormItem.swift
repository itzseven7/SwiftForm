//
//  FirstNameValidator.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
import SwiftForm

final class FirstNameValidator: RegularExpressionValidator {
  init(value: String?) {
    super.init(value: value, patterns: ["^[\\p{L}\\s'‘’'-]*$"])
    errorProvider = self
  }
}

extension FirstNameValidator: RegularExpressionValidatorErrorProvider {
  func unmatchedPatternsError(for patterns: [String]) -> String? {
    return "Your first name can only contain letters, spaces, hyphens and apostrophes."
  }
  
  var emptyError: String? {
    return "Your first name can't be empty."
  }
  
  var noValueError: String? {
    return "You must specify a first name."
  }
}

final class FirstNameFormItem: TextFieldInputFormItem<String> {
  override init(value: String? = nil) {
    super.init(value: value)
    
    title = "First name"
    placeholder = "Tap here"
    autocapitalizationType = .words
    autocorrectionType = .no
    returnKeyType = .next
    clearButtonMode = .whileEditing
    maximumCharacters = 50
  }
  
  override func validator(_ value: String?) -> ValueValidator<String> {
    return FirstNameValidator(value: value)
  }
}

extension FirstNameFormItem: TableViewFormItem {
  var cellType: TableViewFormItemCellType {
    return SignUpCellType.textField
  }
}
