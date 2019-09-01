//
//  FormItem.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

public protocol FormItem: class {
  
  var validator: Validator { get }
  
  var indexPath: IndexPath { get set } // there should not be a public setter
  
  var title: String? { get }
  
  var description: String? { get }
  
  var isEnabled: Bool { get set }
  
  var isHidden: Bool { get set }
  
  var isEditing: Bool { get set }
  
  var beginEditingCallback: (() -> Void)? { get set }
  
  var endEditingCallback: (() -> Void)? { get set }
  
  /// You should use this method to begin editing instead of the callback
  func beginEditing()
  
  /// You should use this method to end editing instead of the callback
  func endEditing()
  
  func validate()
  
  func addObserver(_ observer: FormItemObserver)
}

extension FormItem {
  public var error: String? {
    return validator.error
  }
  
  public func beginEditing() {
    beginEditingCallback?()
  }
  
  public func endEditing() {
    endEditingCallback?()
  }
}

extension FormItem where Self: Equatable {
  public static func ==(lhs: Self, rhs: Self) -> Bool {
    return lhs.indexPath == rhs.indexPath
  }
}

public enum FormItemState {
  case disabled, normal, editing, error
}

extension FormItem {
  public var state: FormItemState {
    guard isEnabled else { return .disabled }
    
    if !(validator.isValid == nil || validator.isValid == true) {
      return .error
    } else {
      if isEditing {
        return .editing
      } else {
        return .normal
      }
    }
  }
}

public protocol FormItemObserver {
  /**
   The observer's priority.
   
   This property tells the form item to choose a proper order to notify its observers. You can decide in which order a type of observer will be notified compared to other types.
   
   The higher the value is, the lesser prioritary the observer is
   
   By default, containers are notified first (priority equal to 1) followed by the form (priority of 2)
   */
  var priority: Int { get }
  
  func onValidationEvent(formItem: FormItem) // validation of the validator
  func onActivationEvent(formItem: FormItem) // isEnabled change
  func onEditingEvent(formItem: FormItem) // isEditing change
  func onVisibilityEvent(formItem: FormItem) // isHidden change
  
  /// Tells the observer that it needs to update itself because of an unknown change in the form item
  ///
  /// - Parameter formItem: the form item
  func onRefreshEvent(formItem: FormItem) // called when a change needs to be reported on observers
}

/// This class defines a form item that handles a simple input
open class InputFormItem<ValueType: Equatable, InputValueType>: FormItem, Equatable {
  public var validator: Validator {
    return valueValidator
  }
  
  public final var valueValidator: ValueValidator<ValueType>!
  
  /// The input value reflects the current value of the input
  public var inputValue: InputValueType?
  
  public var indexPath: IndexPath = IndexPath(item: 0, section: 0)
  
  public var title: String?
  
  public var description: String?
  
  public var isEnabled: Bool = true
  
  public var isHidden: Bool = false
  
  public var isEditing: Bool = false
  
  public var beginEditingCallback: (() -> Void)?
  
  public var endEditingCallback: (() -> Void)?
  
  internal var observers: [FormItemObserver] = []
  
  public init(value: ValueType? = nil) {
    valueValidator = self.validator(value)
    valueValidator.subscribe { [weak self] _ in
      self?.notifyValidationChange()
    }
  }
  
  // You should override this method to provide your own validator
  open func validator(_ value: ValueType?) -> ValueValidator<ValueType> {
    preconditionFailure("You must provide a validator")
  }
  
  open func validate() {
    guard isEnabled && !isHidden else { return }
    valueValidator.validate(self.value(from: inputValue))
  }
  
  open func subscribe<T: Equatable, U>(to formItem: InputFormItem<T, U>,_ handler: @escaping ((T?) -> Void)) {
    formItem.valueValidator.subscribe { (value) in handler(value) }
  }
  
  open func addObserver(_ observer: FormItemObserver) {
    observers.append(observer)
  }
  
  open func notify(_ action: ((FormItemObserver) -> Void)) {
    observers.sorted(by: { $0.priority < $1.priority }).forEach { action($0) }
  }
  
  // Conversion methods
  
  /// Converts the input value to value's type
  ///
  /// The default implementation of this method returns the input value if it has the same type than the value or nil if input value is empty.
  /// Override this method if the input value and value types are different.
  /// - Parameter inputValue: the input value
  /// - Returns: the input value with value's type
  open func value(from inputValue: InputValueType?) -> ValueType? {
    guard let unwrappedValue = inputValue else { return nil }
    
    guard let value = unwrappedValue as? ValueType else {
      preconditionFailure("You must provide a conversion for input value to value's type")
    }
    
    return value
  }
  
  /// Converts the value to input value's type
  ///
  /// The default implementation of this method returns the value if it has the same type than the input value or nil if value is empty.
  /// Override this method if the value and input value types are different.
  /// - Parameter value: the value
  /// - Returns: the value with input value's type
  open func inputValue(from value: ValueType?) -> InputValueType? {
    guard let unwrappedValue = value else { return nil }
    
    guard let inputValue = unwrappedValue as? InputValueType else {
      preconditionFailure("You must provide a conversion for value to input value's type")
    }
    
    return inputValue
  }
}

extension InputFormItem {
  public func notifyValidationChange() {
    notify { [weak self] observer in
      guard let sSelf = self else { return }
      observer.onValidationEvent(formItem: sSelf)
    }
  }
  
  public func notifyActivationChange() {
    notify { [weak self] observer in
      guard let sSelf = self else { return }
      observer.onActivationEvent(formItem: sSelf)
    }
  }
  
  public func notifyEditingChange() {
    notify { [weak self] observer in
      guard let sSelf = self else { return }
      observer.onEditingEvent(formItem: sSelf)
    }
  }
  
  public func notifyVisibilityChange() {
    notify { [weak self] observer in
      guard let sSelf = self else { return }
      observer.onVisibilityEvent(formItem: sSelf)
    }
  }
  
  public func notifyRefreshChange() {
    notify { [weak self] observer in
      guard let sSelf = self else { return }
      observer.onRefreshEvent(formItem: sSelf)
    }
  }
}
