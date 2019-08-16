//
//  DateOfRegistrationFormItem.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
import SwiftForm

final class DateOfRegistrationFormItem: BoundedValueFormItem<Date> {
  init(value: Date?, dateOfBirth: Date?) {
    super.init(value: value)
    
    lowerBound = dateOfBirth
    upperBound = Date()
    errorProvider = self
  }
}

extension DateOfRegistrationFormItem: BoundedValueFormItemErrorProvider {
  var lessThanLowerBoundError: String? {
    return "Your registration date can't be prior to your date of birth."
  }
  
  var greaterThanUpperBoundError: String? {
    return "Your registration date can't be in the future."
  }
  
  var noValueError: String? {
    return "You must specify a date of registration."
  }
}
