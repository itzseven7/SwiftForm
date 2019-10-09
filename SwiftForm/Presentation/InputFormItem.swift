//
//  InputFormItem.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation

/// This class defines a form item that handles a simple input
///
/// You must subclass this class and override the validator() method
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
  
  /// Create a new input form item with an initial value
  ///
  /// You have to provide your validator in the validator(value:) method if you use this initializer
  ///
  /// - Parameter value: the initial value
  public init(value: ValueType? = nil) {
    valueValidator = self.validator(value)
    commonInit(initialValue: value)
  }
  
  /// Creates a new input form item with a validator
  ///
  /// - Parameter validator: the validator
  public init(validator: ValueValidator<ValueType>) {
    valueValidator = validator
    commonInit(initialValue: validator.value)
  }
  
  private func commonInit(initialValue: ValueType?) {
    inputValue = self.inputValue(from: initialValue)
    valueValidator.subscribe { [weak self] _ in
      self?.notifyValidationChange()
    }
  }
  
  // You should override this method to provide your own validator if you use the value initializer
  open func validator(_ value: ValueType?) -> ValueValidator<ValueType> {
    preconditionFailure("You must provide a validator")
  }
  
  public func beginEditing() {
    beginEditingCallback?()
  }
  
  public func endEditing() {
    guard validator.isValid ?? false else { return }
    endEditingCallback?()
  }
  
  open func validate() {
    guard isEnabled && !isHidden else { return }
    valueValidator.validate(self.value(from: inputValue))
  }
  
  public func subscribe<T: Equatable, U>(to formItem: InputFormItem<T, U>,_ handler: @escaping ((T?) -> Void)) {
    formItem.valueValidator.subscribe { (value) in handler(value) }
  }
  
  public func addObserver(_ observer: FormItemObserver) {
    observers.append(observer)
  }
  
  public func notify(_ handler: ((FormItemObserver) -> Void)) {
    observers.sorted(by: { $0.priority > $1.priority }).forEach { handler($0) }
  }
  
  // Conversion methods
  
  /// Converts the input value to value's type
  ///
  /// The default implementation of this method returns the input value if it has the same type than the value or nil if input value is empty.
  /// Override this method if the input value and value types are different.
  ///
  /// This method throws a failure if there is a type mismatch and no specific implementation.
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
  ///
  /// This method throws a failure if there is a type mismatch and no specific implementation.
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
  
  /// Convenience method to notify all observers that a validation occured
  public func notifyValidationChange() {
    notify { [weak self] observer in
      guard let sSelf = self else { return }
      observer.onValidationEvent(formItem: sSelf)
    }
  }
  
  /// Convenience method to notify all observers that the form item has been enabled/disabled
  public func notifyActivationChange() {
    notify { [weak self] observer in
      guard let sSelf = self else { return }
      observer.onActivationEvent(formItem: sSelf)
    }
  }
  
  
  /// Convenience method to notify all observers that the editing state has changed
  public func notifyEditingChange() {
    notify { [weak self] observer in
      guard let sSelf = self else { return }
      observer.onEditingEvent(formItem: sSelf)
    }
  }
  
  /// Convenience method to notify all observers that the form item did become visible/hidden
  public func notifyVisibilityChange() {
    notify { [weak self] observer in
      guard let sSelf = self else { return }
      observer.onVisibilityEvent(formItem: sSelf)
    }
  }
  
  /// Convenience method to notify all observers that a change must be refreshed
  public func notifyRefreshChange() {
    notify { [weak self] observer in
      guard let sSelf = self else { return }
      observer.onRefreshEvent(formItem: sSelf)
    }
  }
}
