//
//  PasswordFormItem.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
import SwiftForm

final class PasswordFormItem: RegularExpressionFormItem {
  
  static let minimumCharacters = 8
  static let maximumCharacters = 128
  
  fileprivate static var numberOfCharactersRegex = "^.{\(minimumCharacters),\(maximumCharacters)}$"
  fileprivate static var lowercaseLetterRegex = ".*[a-z]+.*"
  fileprivate static var uppercaseLetterRegex = ".*[A-Z]+.*"
  fileprivate static var digitRegex = ".*[0-9]+.*"
  fileprivate static var specialCharactersRegex = "^[a-zA-Z0-9!~\\\\ @#$%^&*()_+\\-=\\[\\]{};'‘’':\"\\|,.<>\\/?]*$"
  
  init(password: String? = nil) {
    super.init(value: password,
               patterns: [PasswordFormItem.numberOfCharactersRegex,
                          PasswordFormItem.lowercaseLetterRegex,
                          PasswordFormItem.uppercaseLetterRegex,
                          PasswordFormItem.digitRegex,
                          PasswordFormItem.specialCharactersRegex])
  }
}

extension PasswordFormItem: RegularExpressionFormItemErrorProvider {
  func unmatchedPatternsError(for patterns: [String]) -> String? {
    guard !patterns.contains(PasswordFormItem.numberOfCharactersRegex) else {
      return PatternError.numberOfCharacters.error
    }
    
    guard !patterns.contains(PasswordFormItem.specialCharactersRegex) else {
      return PatternError.specialCharacters.error
    }
    
    var unmatchedPatternsMask = PasswordFormItemRegexOptionSet(rawValue: 0)
    
    patterns.compactMap { optionSet(for: $0) }.forEach { unmatchedPatternsMask = unmatchedPatternsMask.union($0) }
    
    return PatternError.allCases.map { $0.error }[unmatchedPatternsMask.rawValue]
  }
  
  var emptyError: String? {
    return "Your password can't be empty."
  }
  
  var noValueError: String? {
    return "You must specify a password."
  }
  
  private func optionSet(for regularExpression: String) -> PasswordFormItemRegexOptionSet? {
    switch regularExpression {
    case PasswordFormItem.numberOfCharactersRegex:
      return .numberOfCharacters
    case PasswordFormItem.lowercaseLetterRegex:
      return .lowercaseLetter
    case PasswordFormItem.uppercaseLetterRegex:
      return .uppercaseLetter
    case PasswordFormItem.digitRegex:
      return .digit
    case PasswordFormItem.specialCharactersRegex:
      return .specialCharacters
    default:
      return nil
    }
  }
  
  private struct PasswordFormItemRegexOptionSet: OptionSet {
    let rawValue: Int
    
    static let numberOfCharacters = PasswordFormItemRegexOptionSet(rawValue: 0 << 0)
    static let lowercaseLetter = PasswordFormItemRegexOptionSet(rawValue: 1 << 0)
    static let uppercaseLetter = PasswordFormItemRegexOptionSet(rawValue: 1 << 1)
    static let digit = PasswordFormItemRegexOptionSet(rawValue: 1 << 2)
    static let specialCharacters = PasswordFormItemRegexOptionSet(rawValue: 1 << 3)
  }
  
  enum PatternError: CaseIterable {
    case numberOfCharacters
    case lowercaseLetter
    case uppercaseLetter
    case lowercaseAndUppercaseLetter
    case digit
    case lowercaseLetterAndDigit
    case uppercaseLetterAndDigit
    case lowercaseAndUppercaseLettersAndDigit
    case specialCharacters
    
    var error: String {
      switch self {
      case .numberOfCharacters:
        return "Your password must contains at least 8 and less than 128."
      case .lowercaseLetter:
        return "Your password must contains a lowercased letter."
      case .uppercaseLetter:
        return "Your password must contains an uppercased letter."
      case .lowercaseAndUppercaseLetter:
        return "Your password must contains a lowercased and an uppercased letter."
      case .digit:
        return "Your password must contains a digit."
      case .lowercaseLetterAndDigit:
        return "Your password must contains a lowercased letter and a digit."
      case .uppercaseLetterAndDigit:
        return "Your password must contains an uppercased letter and a digit."
      case .lowercaseAndUppercaseLettersAndDigit:
        return "Your password must contains a lowercased letter, an uppercased letter and a digit."
      case .specialCharacters:
        return "Your password contains invalid special characters."
      }
    }
  }
}
