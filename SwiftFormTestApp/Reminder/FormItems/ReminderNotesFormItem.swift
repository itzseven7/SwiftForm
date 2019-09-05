//
//  ReminderNotesFormItem.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
import SwiftForm

final class ReminderNotesFormItem: TextViewInputFormItem {
  override init(value: String? = nil) {
    super.init(value: value)
    
    title = "Notes"
  }
  
  override func validator(_ value: String?) -> ValueValidator<String> {
    return ValueValidator(value: value)
  }
}

extension ReminderNotesFormItem: TableViewFormItem {
  var cellType: TableViewFormItemCellType {
    return ReminderCellType.textView
  }
}
