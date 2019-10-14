//
//  ReminderPriorityFormItem.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
import SwiftForm

enum ReminderPriority: String, CaseIterable, Equatable {
  case none
  case low
  case medium
  case high
  
  var displayName: String {
    switch self {
    case .none:
      return "None"
    case .low:
      return "Low"
    case .medium:
      return "Medium"
    case .high:
      return "High"
    }
  }
  
  var segmentedControlTitle: String {
    switch self {
    case .none:
      return "None"
    case .low:
      return "!"
    case .medium:
      return "!!"
    case .high:
      return "!!!"
    }
  }
  
  static func value(from title: String) -> ReminderPriority? {
    var value: ReminderPriority?
    
    ReminderPriority.allCases.forEach {
      if title == $0.segmentedControlTitle {
        value = $0
      }
    }
    
    return value
  }
}

final class ReminderPriorityValidator: ListValidator<ReminderPriority> {
  init(value: ReminderPriority? = nil) {
    super.init(value: value, values: ReminderPriority.allCases)
  }
}

final class ReminderPriorityFormItem: SegmentedControlInputFormItem<ReminderPriority> {
  init(value: ReminderPriority? = nil) {
    super.init(value: value, values: ReminderPriority.allCases, titles: ReminderPriority.allCases.map { $0.segmentedControlTitle })
    
    title = "Priority"
  }
  
  override func validator(_ value: ReminderPriority?) -> ValueValidator<ReminderPriority> {
    return ReminderPriorityValidator(value: value)
  }
  
  override func value(from inputValue: String?) -> ReminderPriority? {
    return ReminderPriority.value(from: inputValue ?? "")
  }
  
  override func inputValue(from value: ReminderPriority?) -> String? {
    return value?.segmentedControlTitle
  }
}

extension ReminderPriorityFormItem: TableViewFormItem {
  var cellType: TableViewFormItemCellType {
    return ReminderCellType.segmentedControl
  }
}
