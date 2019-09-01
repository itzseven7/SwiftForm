//
//  DatePickerFormItemContainer.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

public protocol DatePickerFormItemContainer: FormItemInputContainer {
  var input: UIDatePicker { get }
}

extension DatePickerFormItemContainer {
  public var datePickerFormItem: DatePickerFormItem? {
    return formItem as? DatePickerFormItem
  }
}

extension DatePickerFormItemContainer {
  public func setUp() {
    formItem?.addObserver(self)
    
    bind()
    finishSetUp()
  }
  
  public func bind() {
    guard let datePickerFormItem = datePickerFormItem else { return }
    
    titleLabel?.text = datePickerFormItem.title
    descriptionLabel?.text = datePickerFormItem.description
    errorLabel?.text = datePickerFormItem.error
    
    input.datePickerMode = datePickerFormItem.datePickerMode
    input.minimumDate = datePickerFormItem.minimumDate
    input.maximumDate = datePickerFormItem.maximumDate
    input.isEnabled = datePickerFormItem.isEnabled
    input.timeZone = datePickerFormItem.timeZone
    
    if let timeZone = datePickerFormItem.timeZone {
      input.calendar.timeZone = timeZone
    }
    
    if let date = datePickerFormItem.date {
      input.setDate(date, animated: true)
    }
  }
  
  public func onRefreshEvent(formItem: FormItem) {
    bind()
  }
}
