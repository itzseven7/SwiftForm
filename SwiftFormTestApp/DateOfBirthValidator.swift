//
//  DateOfBirthValidator.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
import SwiftForm

final class DateOfBirthValidator: BoundedValueValidator<Date> {
  private var minimumAge: Int = 18
  private var maximumAge: Int = 120
  
  override init(value: Date?) {
    super.init(value: value)
    
    let date = Date()
    let calendar = Calendar.current
    
    minimumValue = calendar.date(byAdding: .year, value: -maximumAge, to: date)
    maximumValue = calendar.date(byAdding: .year, value: -minimumAge, to: date)
    errorProvider = self
  }
}

extension DateOfBirthValidator: BoundedValueValidatorErrorProvider {
  var lessThanMinimumValueError: String? {
    return "You can't be too old."
  }
  
  var greaterThanMaximumValueError: String? {
    return "You must be 18 years old."
  }
  
  var noValueError: String? {
    return "You must specify a date of birth."
  }
}
