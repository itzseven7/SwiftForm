//
//  SegmentedControlFormItem.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

public protocol SegmentedControlFormItem: FormItem {
  var titles: [String] { get }
  
  var selectedSegmentIndex: Int { get }
  
  func segmentIsEnabled(at index: Int) -> Bool
  
  func segmentedControlDidChangeSegment(_ segmentedControl: UISegmentedControl)
}

open class SegmentedControlInputFormItem<ValueType: Comparable>: InputFormItem<ValueType, String>, SegmentedControlFormItem {
  public var titles: [String]
  
  public var selectedSegmentIndex: Int = 0
  
  public var values: [ValueType]
  
  public init(value: ValueType?, values: [ValueType], titles: [String]) {
    self.values = values
    self.titles = titles
    
    super.init(value: value)
    
    if let initialValue = value {
      selectedSegmentIndex = values.firstIndex(of: initialValue) ?? 0
    }
  }
  
  open func segmentIsEnabled(at index: Int) -> Bool {
    return true
  }
  
  open func segmentedControlDidChangeSegment(_ segmentedControl: UISegmentedControl) {
    selectedSegmentIndex = segmentedControl.selectedSegmentIndex
    inputValue = titles[selectedSegmentIndex]
    validate()
    notifyRefreshChange()
  }
}
