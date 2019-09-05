//
//  ReminderForm.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
import SwiftForm

enum ReminderCellType: TableViewFormItemCellType {
  
  case textField
  case textView
  case `switch`
  case datePicker
  case segmentedControl
  
  func dequeueCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
    switch self {
    case .textField:
      return tableView.dequeueReusableCell(withIdentifier: String(describing: ReminderTextFieldTableViewCell.self), for: indexPath)
    case .textView:
      return tableView.dequeueReusableCell(withIdentifier: String(describing: ReminderTextViewTableViewCell.self), for: indexPath)
    case .switch:
      return tableView.dequeueReusableCell(withIdentifier: String(describing: ReminderSwitchTableViewCell.self), for: indexPath)
    case .datePicker:
      return tableView.dequeueReusableCell(withIdentifier: String(describing: ReminderDatePickerTableViewCell.self), for: indexPath)
    case .segmentedControl:
      return tableView.dequeueReusableCell(withIdentifier: String(describing: ReminderSegmentedControlTableViewCell.self), for: indexPath)
    }
  }
  
  static func registerCells(for tableView: UITableView) {
    tableView.register(UINib(nibName: String(describing: ReminderTextFieldTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ReminderTextFieldTableViewCell.self))
    tableView.register(UINib(nibName: String(describing: ReminderTextViewTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ReminderTextViewTableViewCell.self))
    tableView.register(UINib(nibName: String(describing: ReminderSwitchTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ReminderSwitchTableViewCell.self))
    tableView.register(UINib(nibName: String(describing: ReminderDatePickerTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ReminderDatePickerTableViewCell.self))
    tableView.register(UINib(nibName: String(describing: ReminderSegmentedControlTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ReminderSegmentedControlTableViewCell.self))
  }
}

final class ReminderEmptyTableSection: BaseTableViewFormSection {
  
  override init() {
    super.init()
    
    headerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
    headerView?.backgroundColor = UIColor(red: 237/255, green: 236/255, blue: 243/255, alpha: 1)
  }
}

final class ReminderForm: BaseTableViewForm {
  
  override init() {
    super.init()
    
    let reminderNameSection = ReminderEmptyTableSection()
    reminderNameSection.items = [ReminderNameFormItem()]
    
    let reminderOnDayFormItem = ReminderOnDayFormItem(value: true)
    let reminderDateFormItem = ReminderDateFormItem()
    
    let reminderDaySection = ReminderEmptyTableSection()
    reminderDaySection.items = [reminderOnDayFormItem, reminderDateFormItem]
    
    reminderDateFormItem.subscribe(to: reminderOnDayFormItem) { [weak reminderDateFormItem] (value) in
      guard let reminderOnDayFormItemIsEnabled = value else { return }
      reminderDateFormItem?.isHidden = !reminderOnDayFormItemIsEnabled
      reminderDateFormItem?.notifyVisibilityChange()
    }
    
    let reminderLocationSection = ReminderEmptyTableSection()
    reminderLocationSection.items = [ReminderOnLocationFormItem()]
    
    let lastSection = ReminderEmptyTableSection()
    lastSection.items = [ReminderPriorityFormItem(), ReminderNotesFormItem()]
    
    sections = [reminderNameSection, reminderDaySection, reminderLocationSection, lastSection]
  }
  
  override func registerCells(for tableView: UITableView) {
    ReminderCellType.registerCells(for: tableView)
  }
}
