//
//  FormItemErrorProviderMocks.swift
//  SwiftFormTests
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
@testable import SwiftForm

class FormItemErrorProviderMock: FormItemErrorProvider {
  var noValueError: String? {
    return "No value error"
  }
}

class TextFormItemErrorProviderMock: FormItemErrorProviderMock, TextFormItemErrorProvider {
  var emptyError: String? {
    return "Empty error"
  }
}

class RegularExpressionFormItemErrorProviderMock: TextFormItemErrorProviderMock, RegularExpressionFormItemErrorProvider {
  func unmatchedPatternsError(for patterns: [String]) -> String {
    return "Unmatched patterns \(patterns.joined(separator: ",")) error"
  }
}

class BoundedValueFormItemErrorProviderMock: FormItemErrorProviderMock, BoundedValueFormItemErrorProvider {
  var lessThanLowerBoundError: String? {
    return "Less than lower error"
  }
  
  var greaterThanUpperBoundError: String? {
    return "Greater than upper error"
  }
}

class ListFormItemErrorProviderMock: FormItemErrorProviderMock, ListFormItemErrorProvider {
  var valueNotInListError: String? {
    return "Value not in list error"
  }
}

class MultiValueListFormItemErrorProviderMock: FormItemErrorProviderMock, MultiValueListFormItemErrorProvider {
  var valuesInExcludedSubsetError: String? {
    return "Values in excluded subset error"
  }
  
  var valuesNotInListError: String? {
    return "Values not in list error"
  }
}
