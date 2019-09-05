//
//  LastNameValidator.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
import SwiftForm

final class LastNameValidator: RegularExpressionValidator {
  init(value: String?) {
    super.init(value: value, patterns: ["^[\\p{L}\\s'‘’'-]*$"])
    errorProvider = self
  }
}

extension LastNameValidator: RegularExpressionValidatorErrorProvider {
  func unmatchedPatternsError(for patterns: [String]) -> String? {
    return "Your last name can only contain letters, spaces, hyphens and apostrophes."
  }
  
  var emptyError: String? {
    return "Your last name can't be empty."
  }
  
  var noValueError: String? {
    return "You must specify a last name."
  }
}

final class LastNameFormItem: TextFieldInputFormItem<String> {
  override init(value: String? = nil) {
    super.init(value: value)
    
    title = "Last name"
    placeholder = "Tap here"
    autocapitalizationType = .words
    autocorrectionType = .no
    returnKeyType = .next
    clearButtonMode = .whileEditing
    maximumCharacters = 50
  }
  
  override func validator(_ value: String?) -> ValueValidator<String> {
    return LastNameValidator(value: value)
  }
}

extension LastNameFormItem: TableViewFormItem {
  var cellType: TableViewFormItemCellType {
    return SignUpCellType.textField
  }
}
