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
  
  private var nameFormItem: ReminderNameFormItem
  private var onDayFormItem: ReminderOnDayFormItem
  private var dateFormItem: ReminderDateFormItem
  private var onLocationFormItem: ReminderOnLocationFormItem
  private var priorityFormItem: ReminderPriorityFormItem
  private var notesFormItem: ReminderNotesFormItem
  
  private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale.current
    formatter.dateFormat = "EEEE, MMM, d, y, hh:mm a"
    return formatter
  }()
  
  override init() {
    nameFormItem = ReminderNameFormItem()
    onDayFormItem = ReminderOnDayFormItem(value: true)
    dateFormItem = ReminderDateFormItem(value: Date(timeInterval: -(3600 * 24), since: Date()))
    onLocationFormItem = ReminderOnLocationFormItem(value: false)
    priorityFormItem = ReminderPriorityFormItem()
    notesFormItem = ReminderNotesFormItem()
    
    super.init()
    
    configureForm()
  }
  
  private func configureForm() {
    let reminderNameSection = ReminderEmptyTableSection()
    reminderNameSection.items = [nameFormItem]
    
    let reminderDaySection = ReminderEmptyTableSection()
    reminderDaySection.items = [onDayFormItem, dateFormItem]
    
    dateFormItem.subscribe(to: onDayFormItem) { [weak dateFormItem] (value) in
      guard let onDayFormItemIsEnabled = value else { return }
      dateFormItem?.isHidden = !onDayFormItemIsEnabled
      dateFormItem?.notifyVisibilityChange()
    }
    
    let reminderLocationSection = ReminderEmptyTableSection()
    reminderLocationSection.items = [onLocationFormItem]
    
    let lastSection = ReminderEmptyTableSection()
    lastSection.items = [priorityFormItem, notesFormItem]
    
    sections = [reminderNameSection, reminderDaySection, reminderLocationSection, lastSection]
  }
  
  override func registerCells(for tableView: UITableView) {
    ReminderCellType.registerCells(for: tableView)
  }
  
  func getValues() -> ReminderFormValues? {
    
    var values = ReminderFormValues()
    
    if let name = nameFormItem.valueValidator.value {
      values.name =  name
    }
    
    if let onDay = onDayFormItem.valueValidator.value?.description {
      values.onDay = onDay
    }
    
    if let date = dateFormItem.valueValidator.value {
      values.date = dateFormatter.string(from: date)
    }
    
    if let onLocation = onLocationFormItem.valueValidator.value?.description {
      values.onLocation = onLocation
    }
    
    if let priority = priorityFormItem.valueValidator.value {
      values.priority = priority.displayName
    }
    
    if let notes = notesFormItem.valueValidator.value {
      values.notes = notes
    }
    
    return values
  }
}

struct ReminderFormValues {
  var name: String = "nil"
  var onDay: String = "nil"
  var date: String = "nil"
  var onLocation: String = "nil"
  var priority: String = "nil"
  var notes: String = "nil"
}
