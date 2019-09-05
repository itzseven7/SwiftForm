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
}

extension PlaceOfBirthFormItem: TableViewFormItem {
  var cellType: TableViewFormItemCellType {
    return SignUpCellType.pickerInput
  }
}

extension PlaceOfBirthFormItem: TextFieldResponderAdapter {
  var text: String? {
    return inputValue
  }
  
  var placeholder: String? {
    return "Tap here"
  }
}
