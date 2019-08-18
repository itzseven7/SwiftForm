//
//  ValidatorErrorProviderMocks.swift
//  SwiftFormTests
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
@testable import SwiftForm

class ValueValidatorErrorProviderMock: ValueValidatorErrorProvider {
  var noValueError: String? {
    return "No value error"
  }
}

class TextValidatorErrorProviderMock: ValueValidatorErrorProviderMock, TextValidatorErrorProvider {
  var emptyError: String? {
    return "Empty error"
  }
}

class RegularExpressionValidatorErrorProviderMock: TextValidatorErrorProviderMock, RegularExpressionValidatorErrorProvider {
  func unmatchedPatternsError(for patterns: [String]) -> String? {
    return "Unmatched patterns \(patterns.joined(separator: ",")) error"
  }
}

class BoundedValueValidatorErrorProviderMock: ValueValidatorErrorProviderMock, BoundedValueValidatorErrorProvider {
  var lessThanMinimumValueError: String? {
    return "Less than min value"
  }
  
  var greaterThanMaximumValueError: String? {
    return "Greater than max value"
  }
}

class ListValidatorErrorProviderMock: ValueValidatorErrorProviderMock, ListValidatorErrorProvider {
  var valueNotInListError: String? {
    return "Value not in list error"
  }
}

class MultiValueListValidatorErrorProviderMock: ValueValidatorErrorProviderMock, MultiValueListValidatorErrorProvider {
  var valuesInExcludedSubsetError: String? {
    return "Values in excluded subset error"
  }
  
  var valuesNotInListError: String? {
    return "Values not in list error"
  }
}
