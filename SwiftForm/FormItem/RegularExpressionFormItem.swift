//
//  RegularExpressionFormItem.swift
//  CPA-ios
//
//  Copyright © 2019 itzseven7. All rights reserved.
//

import Foundation

protocol RegularExpressionFormItemErrorProvider: TextFormItemErrorProvider {
  
  func unmatchedPatternsError(for patterns: [String]) -> String
}

open class RegularExpressionFormItem: TextFormItem {
  
  var patterns: [String]
  
  private var regularExpressionErrorProvider: RegularExpressionFormItemErrorProvider? {
    return errorProvider as? RegularExpressionFormItemErrorProvider
  }
  
  init(value: String? = nil, patterns: [String]) {
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
