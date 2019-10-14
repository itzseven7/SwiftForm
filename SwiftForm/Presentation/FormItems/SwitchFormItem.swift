//
//  SwitchFormItem.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

public protocol SwitchFormItem: FormItem {
  var isOn: Bool { get }
  
  func switchDidChangeValue(_ switch: UISwitch)
}

open class SwitchInputFormItem<ValueType: Equatable>: InputFormItem<ValueType, Bool>, SwitchFormItem {
  public var isOn: Bool = false
  
  public override init(value: ValueType?) {
    super.init(value: value)
    
    isOn = inputValue(from: valueValidator.value) ?? false
  }
  
  public func switchDidChangeValue(_ switch: UISwitch) {
    inputValue = `switch`.isOn
    isOn = `switch`.isOn
    validate()
    notifyRefreshChange()
  }
}
