//
//  RegularExpressionValidator.swift
//  CPA-ios
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation

public protocol RegularExpressionValidatorErrorProvider: TextValidatorErrorProvider {
  
  func unmatchedPatternsError(for patterns: [String]) -> String?
}

open class RegularExpressionValidator: TextValidator {
  
  var patterns: [String]
  
  private var regularExpressionErrorProvider: RegularExpressionValidatorErrorProvider? {
    return errorProvider as? RegularExpressionValidatorErrorProvider
  }
  
  public init(value: String? = nil, patterns: [String]) {
    self.patterns = patterns
    super.init(value: value)
  }
  
  override public func checkValidity() {
    super.checkValidity()
    
    guard let value = value, isValid ?? false else {
      return
    }
    
    let unmatchedPatterns = patterns.filter { value.range(of: $0, options: .regularExpression) == nil }
    
    isValid = unmatchedPatterns.isEmpty
    error = isValid ?? false ? nil : regularExpressionErrorProvider?.unmatchedPatternsError(for: unmatchedPatterns)
  }
}
