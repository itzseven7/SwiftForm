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

open class SwitchInputFormItem<ValueType: Comparable>: InputFormItem<ValueType, Bool>, SwitchFormItem {
  public var isOn: Bool = false
  
  public func switchDidChangeValue(_ switch: UISwitch) {
    inputValue = `switch`.isOn
    validate()
    notifyRefreshChange()
  }
}
