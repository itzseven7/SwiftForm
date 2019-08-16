//
//  LastNameFormItem.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
import SwiftForm

final class LastNameFormItem: RegularExpressionFormItem {
  init(value: String?) {
    super.init(value: value, patterns: ["^[\\p{L}\\s'‘’'-]*$"])
    errorProvider = self
  }
}

extension LastNameFormItem: RegularExpressionFormItemErrorProvider {
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
