//
//  PasswordFormItem+Error.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
import SwiftForm

struct PasswordValidatorErrorProvider: RegularExpressionValidatorErrorProvider {
  func unmatchedPatternsError(for patterns: [String]) -> String? {
    guard !patterns.contains(PasswordValidator.numberOfCharactersRegex) else {
      return PatternError.numberOfCharacters.error
    }
    
    guard !patterns.contains(PasswordValidator.specialCharactersRegex) else {
      return PatternError.specialCharacters.error
    }
    
    var unmatchedPatternsMask = PasswordValidatorRegexOptionSet(rawValue: 0)
    
    patterns.compactMap { optionSet(for: $0) }.forEach { unmatchedPatternsMask = unmatchedPatternsMask.union($0) }
    
    return PatternError.allCases.map { $0.error }[unmatchedPatternsMask.rawValue]
  }
  
  var emptyError: String? {
    return "Your password can't be empty."
  }
  
  var noValueError: String? {
    return "You must specify a password."
  }
  
  private func optionSet(for regularExpression: String) -> PasswordValidatorRegexOptionSet? {
    switch regularExpression {
    case PasswordValidator.numberOfCharactersRegex:
      return .numberOfCharacters
    case PasswordValidator.lowercaseLetterRegex:
      return .lowercaseLetter
    case PasswordValidator.uppercaseLetterRegex:
      return .uppercaseLetter
    case PasswordValidator.digitRegex:
      return .digit
    case PasswordValidator.specialCharactersRegex:
      return .specialCharacters
    default:
      return nil
    }
  }
  
  private struct PasswordValidatorRegexOptionSet: OptionSet {
    let rawValue: Int
    
    static let numberOfCharacters = PasswordValidatorRegexOptionSet(rawValue: 0 << 0)
    static let lowercaseLetter = PasswordValidatorRegexOptionSet(rawValue: 1 << 0)
    static let uppercaseLetter = PasswordValidatorRegexOptionSet(rawValue: 1 << 1)
    static let digit = PasswordValidatorRegexOptionSet(rawValue: 1 << 2)
    static let specialCharacters = PasswordValidatorRegexOptionSet(rawValue: 1 << 3)
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
