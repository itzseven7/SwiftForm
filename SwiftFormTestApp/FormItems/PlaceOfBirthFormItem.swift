//
//  PlaceOfBirthFormItem.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
import SwiftForm

final class PlaceOfBirthValidator: ListValidator<String> {
  init(countryCode: String?) {
    super.init(value: countryCode, values: NSLocale.isoCountryCodes)
  }
}

final class PlaceOfBirthFormItem: PickerViewInputFormItem<String> {
  init(value: String? = nil) {
    super.init(value: value, values: NSLocale.isoCountryCodes, titles: NSLocale.isoCountryCodes.compactMap {
      let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: $0])
      return NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? nil
    })
    
    title = "Place of birth"
  }
  
  override func validator(_ value: String?) -> ValueValidator<String> {
    return PlaceOfBirthValidator(countryCode: value)
  }
  
  override func value(from inputValue: String?) -> String? {
    return inputValue
  }
}

extension PlaceOfBirthFormItem: TableViewFormItem {
  var cellType: TableViewFormItemCellType {
    return CellType.pickerInput
  }
}

extension PlaceOfBirthFormItem: TextFieldFormItemAdapter {
  var text: String? {
    return inputValue
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
