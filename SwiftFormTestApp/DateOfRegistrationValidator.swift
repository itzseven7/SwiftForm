//
//  DateOfRegistrationValidator.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
import SwiftForm

final class DateOfRegistrationValidator: BoundedValueValidator<Date> {
  init(value: Date?, dateOfBirth: Date?) {
    super.init(value: value)
    
    minimumValue = dateOfBirth
    maximumValue = Date()
    errorProvider = self
  }
}

extension DateOfRegistrationValidator: BoundedValueValidatorErrorProvider {
  var lessThanMinimumValueError: String? {
    return "Your registration date can't be prior to your date of birth."
  }
  
  var greaterThanMaximumValueError: String? {
    return "Your registration date can't be in the future."
  }
  
  var noValueError: String? {
    return "You must specify a date of registration."
  }
}
