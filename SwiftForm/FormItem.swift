//
//  FormItem.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

protocol FormItem: class {
  
  var validator: Validator { get }
  
  var indexPath: IndexPath { get }
  
  var title: String? { get }
  
  var titleAttributedString: NSAttributedString? { get }
  
  var description: String? { get }
  
  var descriptionAttributedString: NSAttributedString? { get }
  
  var errorAttributedString: NSAttributedString? { get }
  
  var isEnabled: Bool { get set }
  
  var isHidden: Bool { get set }
  
  var isEditing: Bool { get set }
  
  var beginEditingCallback: (() -> Void)? { get set }
  
  var endEditingCallback: (() -> Void)? { get set }
  
  /// You should use this method to begin editing instead of the callback
  func beginEditing()
  
  /// You should use this method to begin editing instead of the callback
  func endEditing()
}

extension FormItem {
  func beginEditing() {
    beginEditingCallback?()
  }
  
  func endEditing() {
    endEditingCallback?()
  }
}

class BaseFormItem<ValueType: Comparable, InputValueType>: FormItem {
  var validator: Validator {
    return base
  }
  
  var base: ValueValidator<ValueType>!
  
  var value: ValueType? {
    return base.value
  }
  
  public var inputValue: InputValueType?
  
  public var indexPath: IndexPath = IndexPath(item: 0, section: 0)
  
  public var title: String?
  
  var titleAttributedString: NSAttributedString?
  
  public var description: String?
  
  var descriptionAttributedString: NSAttributedString?
  
  var errorAttributedString: NSAttributedString?
  
  public var isEnabled: Bool = true
  
  public var isHidden: Bool = false
  
  public var isEditing: Bool = false
  
  public var beginEditingCallback: (() -> Void)?
  
  public var endEditingCallback: (() -> Void)?
  
  init(value: ValueType? = nil) {
    base = self.validator(value)
  }
  
  // You should override this method to provide your own validator
  public func validator(_ value: ValueType?) -> ValueValidator<ValueType> {
    return ValueValidator(value: value)
  }
  
  // Conversion methods
  
  func value(from inputValue: InputValueType?) -> ValueType? {
    // Needs implementation in subclass
    return nil
  }
  
  func inputValue(from value: ValueType?) -> InputValueType? {
    // Needs implementation in subclass
    return nil
  }
}

class TextFormItemViewModel<ValueType: Comparable>: BaseFormItem<ValueType, String> {
  var text: String? {
    let inputValue = self.inputValue(from: base.value)
    return formatted(inputValue) ?? inputValue
  }
  
  // Conversion methods
  
  func formatted(_ value: String?) -> String? {
    // Needs implementation in subclass
    return nil
  }
  
  func unformatted(_ value: String?) -> String? {
    // Needs implementation in subclass
    return nil
  }
}

class TextFieldFormItemViewModel<ValueType: Comparable>: TextFormItemViewModel<ValueType> {
  
}
