//
//  StepperFormItem.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

public protocol StepperFormItem: FormItem {
  var value: Double { get }
  
  /**
   The stepper minimum value's

   [Property reference](https://developer.apple.com/documentation/uikit/uistepper/1624078-minimumvalue)
   */
  var minimumValue: Double { get }
  
  var maximumValue: Double { get }
  
  var stepValue: Double { get }
  
  var isContinuous: Bool { get }
  
  var autorepeat: Bool { get }
  
  var wraps: Bool { get }
  
  func stepperDidChangeValue(_ stepper: UIStepper)
}

open class StepperInputFormItem<ValueType: Equatable>: InputFormItem<ValueType, Double>, StepperFormItem {
  public var value: Double = 0
  
  public var minimumValue: Double = 0
  
  public var maximumValue: Double = 100
  
  public var stepValue: Double = 1
  
  public var isContinuous: Bool = false
  
  public var autorepeat: Bool = true
  
  public var wraps: Bool = false
  
  public func stepperDidChangeValue(_ stepper: UIStepper) {
    inputValue = stepper.value
    validate()
    notifyRefreshChange()
  }
}
