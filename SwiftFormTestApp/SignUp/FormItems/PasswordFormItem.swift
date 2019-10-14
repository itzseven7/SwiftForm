//
//  PasswordValidator.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
import SwiftForm

final class PasswordValidator: RegularExpressionValidator {
  
  static let minimumCharacters = 8
  static let maximumCharacters = 128
  
  static var numberOfCharactersRegex = "^.{\(minimumCharacters),\(maximumCharacters)}$"
  static var lowercaseLetterRegex = ".*[a-z]+.*"
  static var uppercaseLetterRegex = ".*[A-Z]+.*"
  static var digitRegex = ".*[0-9]+.*"
  static var specialCharactersRegex = "^[a-zA-Z0-9!~\\\\ @#$%^&*()_+\\-=\\[\\]{};'‘’':\"\\|,.<>\\/?]*$"
  
  init(value: String? = nil) {
    super.init(value: value,
               patterns: [PasswordValidator.numberOfCharactersRegex,
                          PasswordValidator.lowercaseLetterRegex,
                          PasswordValidator.uppercaseLetterRegex,
                          PasswordValidator.digitRegex,
                          PasswordValidator.specialCharactersRegex])
    errorProvider = PasswordValidatorErrorProvider()
  }
}

final class PasswordFormItem: TextFieldInputFormItem<String> {
  
  override init(value: String? = nil) {
    super.init(value: value)
    
    title = "Password"
    placeholder = "Tap here"
    description = "At least eight characters including one uppercase letter, one lowercase letter and one digit."
    autocorrectionType = .no
    isSecureTextEntry = true
    returnKeyType = .done
    maximumCharacters = 128
  }
  
  override func validator(_ value: String?) -> ValueValidator<String> {
    return PasswordValidator(value: value)
  }
}

extension PasswordFormItem: TableViewFormItem {
  var cellType: TableViewFormItemCellType {
    return SignUpCellType.textField
  }
}
