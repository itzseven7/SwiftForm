//
//  PickerViewFormItem.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

public protocol PickerViewFormItem: FormItem {
  
  var titles: [String] { get }
  
  var selectedRowIndex: Int { get }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
}

open class PickerViewInputFormItem<ValueType: Comparable>: InputFormItem<ValueType, String>, PickerViewFormItem {
  
  public var emptyTitle: String = "-"
  
  public var values: [ValueType]
  
  private var initialTitles: [String]
  
  public var titles: [String] {
    get {
      if hasEmptyValue {
        return [emptyTitle] + initialTitles
      } else {
        return initialTitles
      }
    }
    
    set {
      initialTitles = newValue
    }
  }
  
  private var hasEmptyValue: Bool {
    return !validator.isMandatory
  }
  
  public var selectedRowIndex: Int = 0
  
  public init(value: ValueType?, values: [ValueType], titles: [String]) {
    self.values = values
    self.initialTitles = titles
    
    super.init(value: value)
    
    selectedRowIndex = index(for: value) ?? 0
  }
  
  private func value(for index: Int) -> ValueType? {
    guard index < values.count, index > 0 else {
      return nil
    }
    
    return hasEmptyValue ? values[index-1] : values[index]
  }
  
  private func index(for value: ValueType?) -> Int? {
    guard let value = value, let index = values.firstIndex(of: value) else {
      return nil
    }
    
    return hasEmptyValue ? index + 1 : index
  }
  
  public func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return titles.count
  }
  
  public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return titles[row]
  }
  
  public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    selectedRowIndex = row
    inputValue = titles[row]
    notify { [weak self] (observer) in
      guard let sSelf = self else { return }
      observer.onRefreshEvent(formItem: sSelf)
    }
  }
}
