//
//  EmailAddressFormItem.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
import SwiftForm

final class EmailAddressFormItem: RegularExpressionFormItem {
  init(email: String? = nil) {
    super.init(value: email, patterns: ["^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"])
    
    errorProvider = self
  }
}

extension EmailAddressFormItem: RegularExpressionFormItemErrorProvider {
  func unmatchedPatternsError(for patterns: [String]) -> String? {
    return "Your email address has an invalid format."
  }
  
  var emptyError: String? {
    return "You email address can't be empty."
  }
  
  var noValueError: String? {
    return "You must specify an email address."
  }
}
