//
//  ReminderDateFormItem.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
import SwiftForm

final class ReminderDateFormItem: DatePickerInputFormItem<Date> {
  override init(value: Date? = nil) {
    super.init(value: value)
    
    minimumDate = Date()
  }
  
  override func validator(_ value: Date?) -> ValueValidator<Date> {
    return BoundedValueValidator(value: value)
  }
  
  override func datePickerValueChanged(_ datePicker: UIDatePicker) {
    super.datePickerValueChanged(datePicker)
    validate()
  }
}

extension ReminderDateFormItem: TableViewFormItem {
  var cellType: TableViewFormItemCellType {
    return ReminderCellType.datePicker
  }
}
