//
//  SliderFormItem.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

public protocol SliderFormItem: FormItem {
  var value: Float { get }
  
  var minimumValue: Float { get }
  
  var maximumValue: Float { get }
  
  var minimumValueImage: UIImage? { get }
  
  var maximumValueImage: UIImage? { get }
  
  var isContinuous: Bool { get }
  
  func sliderDidChangeValue(_ slider: UISlider)
}

open class SliderInputFormItem<ValueType: Equatable>: InputFormItem<ValueType, Float>, SliderFormItem {
  public var value: Float = 0
  
  public var minimumValue: Float = 0
  
  public var maximumValue: Float = 1
  
  public var minimumValueImage: UIImage?
  
  public var maximumValueImage: UIImage?
  
  /// To avoid continuous validation, the slider must not be continuous
  public var isContinuous: Bool = false
  
  public func sliderDidChangeValue(_ slider: UISlider) {
    inputValue = slider.value
    validate()
    notifyRefreshChange()
  }
}
