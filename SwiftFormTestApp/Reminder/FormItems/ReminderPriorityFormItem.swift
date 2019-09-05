//
//  ReminderPriorityFormItem.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
import SwiftForm

final class ReminderPriorityValidator: ListValidator<String> {
  init(value: String? = nil) {
    super.init(value: value, values: ["none", "low", "medium", "high"])
  }
}

final class ReminderPriorityFormItem: SegmentedControlInputFormItem<String> {
  let titlesValue = ["None", "!", "!!", "!!!"]
  
  init(value: String? = nil) {
    super.init(value: value, values: ReminderPriorityValidator().values, titles: ["None", "!", "!!", "!!!"])
    
    title = "Priority"
  }
  
  override func validator(_ value: String?) -> ValueValidator<String> {
    return ReminderPriorityValidator(value: value)
  }
}

extension ReminderPriorityFormItem: TableViewFormItem {
  var cellType: TableViewFormItemCellType {
    return ReminderCellType.segmentedControl
  }
}
