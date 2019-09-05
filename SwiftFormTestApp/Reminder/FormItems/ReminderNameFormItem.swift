//
//  ReminderNameFormItem.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
import SwiftForm

final class ReminderNameFormItem: TextFieldInputFormItem<String> {
  
  override init(value: String? = nil) {
    super.init(value: value)
    
    placeholder = "Tap here.."
  }
  
  override func validator(_ value: String?) -> ValueValidator<String> {
    return ValueValidator(value: value)
  }
}

extension ReminderNameFormItem: TableViewFormItem {
  var cellType: TableViewFormItemCellType {
    return ReminderCellType.textField
  }
}
