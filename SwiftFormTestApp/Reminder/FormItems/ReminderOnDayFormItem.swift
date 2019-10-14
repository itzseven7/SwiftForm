//
//  ReminderOnDayFormItem.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
import SwiftForm

final class ReminderOnDayFormItem: SwitchInputFormItem<Bool> {
  override init(value: Bool? = nil) {
    super.init(value: value)
    
    title = "Remind me on a day"
  }
  
  override func validator(_ value: Bool?) -> ValueValidator<Bool> {
    return ValueValidator(value: value)
  }
}

extension ReminderOnDayFormItem: TableViewFormItem {
  var cellType: TableViewFormItemCellType {
    return ReminderCellType.switch
  }
}
