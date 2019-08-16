//
//  DateOfBirthFormItem.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
import SwiftForm

final class DateOfBirthFormItem: BoundedValueFormItem<Date> {
  private var minimumAge: Int = 18
  private var maximumAge: Int = 120
  
  override init(value: Date?) {
    super.init(value: value)
    
    let date = Date()
    let calendar = Calendar.current
    
    lowerBound = calendar.date(byAdding: .year, value: -maximumAge, to: date)
    upperBound = calendar.date(byAdding: .year, value: -minimumAge, to: date)
    errorProvider = self
  }
}

extension DateOfBirthFormItem: BoundedValueFormItemErrorProvider {
  var lessThanLowerBoundError: String? {
    return "You can't be too old."
  }
  
  var greaterThanUpperBoundError: String? {
    return "You must be 18 years old."
  }
  
  var noValueError: String? {
    return "You must specify a date of birth."
  }
}
