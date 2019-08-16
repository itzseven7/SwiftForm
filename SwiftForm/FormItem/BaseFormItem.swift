//
//  BaseFormItem.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation

/// This class defines a form item with a generic value. You usually do not instantiate this class directly, but subclass it.
open class BaseFormItem<ValueType: Equatable>: FormItem {
  
  /// The current value of the form item
  public var value: ValueType? {
    didSet {
      checkValidity()
    }
  }
  
  /// The value set at form item initialization
  internal var initialValue: ValueType?
  
  /// Validates the given value
  /// A default validator is created during form item initialization. It assigns the new value to the form item, validates it and notifies all form item's subscribers
  public var validator: ((ValueType?) -> Void)?
  
  /// An error object which defines error messages
  public var errorProvider: FormItemErrorProvider?
  
  public var hasChanges: Bool {
    return value != initialValue
  }
  
  public var error: String?
  
  public var isValid: Bool?
  public var isMandatory: Bool = true {
    didSet {
      checkValidity()
    }
  }
  
  private var subscribersHandler: [((ValueType?) -> Void)] = []
  
  /// Initializes a new form item
  ///
  /// - Parameter value: the initial value
  public init(value: ValueType? = nil) {
    self.value = value
    self.initialValue = value
    
    // Default validator
    self.validator = { [weak self] value in
      self?.value = value
      self?.checkValidity()
      self?.notify()
    }
    
    if value != nil {
      checkValidity()
    }
  }
  
  public func checkValidity() {
    guard isMandatory else {
      isValid = true
      error = nil
      return
    }
    
    isValid = value != nil
    error = !(isValid ?? true) ? errorProvider?.noValueError : nil
  }
  
  public func subscribe(_ handler: @escaping ((ValueType?) -> Void)) {
    subscribersHandler.append(handler)
  }
  
  /// Notifies all observers
  internal func notify() {
    subscribersHandler.forEach { $0(value) }
  }
  
  /// Resets the form item
  public func reset() {
    value = initialValue
    isValid = nil
    error = nil
  }
}
