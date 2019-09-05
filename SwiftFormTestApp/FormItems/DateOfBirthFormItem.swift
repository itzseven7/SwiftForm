//
//  DateOfBirthValidator.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
import SwiftForm

final class DateOfBirthValidator: BoundedValueValidator<Date> {
  private var minimumAge: Int = 18
  private var maximumAge: Int = 120
  
  override init(value: Date?) {
    super.init(value: value)
    
    let date = Date()
    let calendar = Calendar.current
    
    minimumValue = calendar.date(byAdding: .year, value: -maximumAge, to: date)
    maximumValue = calendar.date(byAdding: .year, value: -minimumAge, to: date)
    errorProvider = self
  }
}

extension DateOfBirthValidator: BoundedValueValidatorErrorProvider {
  var lessThanMinimumValueError: String? {
    return "You can't be too old."
  }
  
  var greaterThanMaximumValueError: String? {
    return "You must be 18 years old."
  }
  
  var noValueError: String? {
    return "You must specify a date of birth."
  }
}

final class DateOfBirthFormItem: DatePickerInputFormItem<Date> {
  
  private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.current
    dateFormatter.dateFormat = "MM / dd / yyyy"
    return dateFormatter
  }()
  
  private var dateOfBirthValidator: DateOfBirthValidator {
    return base as! DateOfBirthValidator
  }
  
  override init(value: Date? = nil) {
    super.init(value: value)
    
    title = "Date of birth"
    date = dateOfBirthValidator.value
    minimumDate = dateOfBirthValidator.minimumValue
    maximumDate = dateOfBirthValidator.maximumValue
    datePickerMode = .date
  }
  
  override func validator(_ value: Date?) -> DateOfBirthValidator {
    return DateOfBirthValidator(value: value)
  }
  
  override func value(from inputValue: Date?) -> Date? {
    return inputValue
  }
}

extension DateOfBirthFormItem: TableViewFormItem {
  var cellType: TableViewFormItemCellType {
    return CellType.datePickerInput
  }
}

extension DateOfBirthFormItem: TextFieldFormItemAdapter {
  var text: String? {
    guard let value = date else { return nil }
    return dateFormatter.string(from: value)
  }
  
  var placeholder: String? {
    return "Tap here"
  }
  
  var leftViewMode: UITextField.ViewMode {
    return .never
  }
  
  var leftView: UIView? {
    return nil
  }
  
  var rightViewMode: UITextField.ViewMode {
    return .never
  }
  
  var rightView: UIView? {
    return nil
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    isEditing = true
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    isEditing = false
  }
}
