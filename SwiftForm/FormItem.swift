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
  
  var titleAttributedString: NSAttributedString? { get } // we should remove this and add a configureTitleLabel(_ label: UILabel) method
  
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

protocol FormItemObserver {
  func onValidationEvent() // validation of the validator
  func onActivationEvent() // isEnabled change
  func onEditingEvent() // isEditing change
  func onVisibilityEvent() // isHidden change
}

class FormItemInput<ValueType: Comparable, InputValueType>: FormItem {
  var validator: Validator {
    return base
  }
  
  public final var base: ValueValidator<ValueType>!
  
  var value: ValueType? {
    return base.value
  }
  
  /// The input value reflects the current value of the input
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
  
  public func validate() {
    base.validate(self.value(from: inputValue))
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

class TextFormItemInput<ValueType: Comparable>: FormItemInput<ValueType, String> {
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

class TextFieldFormItemInput<ValueType: Comparable>: TextFormItemInput<ValueType> {
  
}
