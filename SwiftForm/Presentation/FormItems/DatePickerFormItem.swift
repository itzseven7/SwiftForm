//
//  DatePickerFormItem.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

public protocol DatePickerFormItem: FormItem {
  
  var date: Date? { get }
  
  var minimumDate: Date? { get }
  
  var maximumDate: Date? { get }
  
  var datePickerMode: UIDatePicker.Mode { get }
  
  var calendar: Calendar? { get }
  
  var locale: Locale? { get }
  
  var timeZone: TimeZone? { get }
  
  func datePickerValueChanged(_ datePicker: UIDatePicker)
}

open class DatePickerInputFormItem<ValueType: Equatable>: InputFormItem<ValueType, Date>, DatePickerFormItem {
  public var date: Date? {
    return inputValue
  }
  
  public var minimumDate: Date?
  
  public var maximumDate: Date?
  
  public var datePickerMode: UIDatePicker.Mode = .dateAndTime
  
  public var calendar: Calendar? = Calendar.current
  
  public var locale: Locale? = Locale.current
  
  public var timeZone: TimeZone?
  
  open func datePickerValueChanged(_ datePicker: UIDatePicker) {
    inputValue = datePicker.date
    notifyRefreshChange()
  }
}
