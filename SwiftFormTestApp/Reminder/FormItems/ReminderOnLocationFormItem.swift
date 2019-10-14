//
//  ReminderOnLocationFormItem.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
import SwiftForm

final class ReminderOnLocationFormItem: SwitchInputFormItem<Bool> {
  override init(value: Bool? = nil) {
    super.init(value: value)
    
    title = "Remind me at a location"
  }
  
  override func validator(_ value: Bool?) -> ValueValidator<Bool> {
    return ValueValidator(value: value)
  }
}

extension ReminderOnLocationFormItem: TableViewFormItem {
  var cellType: TableViewFormItemCellType {
    return ReminderCellType.switch
  }
}
