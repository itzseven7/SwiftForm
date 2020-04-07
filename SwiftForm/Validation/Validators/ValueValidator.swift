//
//  ValueValidator.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation

public protocol ValueValidatorErrorProvider {
  
  var noValueError: String? { get }
}

/// This class defines a validator with a generic value. You usually do not instantiate this class directly, but subclass it.
open class ValueValidator<ValueType: Equatable>: Validator {
  
  public typealias ValidationHandler = ((ValueType?) -> (isValid: Bool, error: String?))
  
  /// The current value of the validator
  public var value: ValueType?
  
  /// The value set at validator initialization
  internal var initialValue: ValueType?
  
  /// An error object which defines error messages
  public var errorProvider: ValueValidatorErrorProvider?
  
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
  
  private var validationHandler: ValidationHandler?
  private var subscriptions: [((ValueType?) -> Void)] = []
  
  /// Initializes a value validator
  /// - Parameter value: the initial value
  /// - Parameter handler: a custom handler to validate a value
  public init(value: ValueType? = nil, _ handler: ValidationHandler? = nil) {
    self.value = value
    self.initialValue = value
    self.validationHandler = handler
    
    if value != nil {
      checkValidity()
    }
  }
  
  open func validate(_ value: ValueType?) {
    self.value = value
    checkValidity()
    notify()
  }
  
  open func checkValidity() {
    guard isMandatory else {
      isValid = true
      error = nil
      return
    }
    
    if let handler = validationHandler {
      let handlerResult = handler(value)
      isValid = handlerResult.isValid
      error = !(isValid ?? true) ? handlerResult.error : nil 
    } else {
      isValid = value != nil
      error = !(isValid ?? true) ? errorProvider?.noValueError : nil
    }
  }
  
  public func subscribe(_ handler: @escaping ((ValueType?) -> Void)) {
    subscriptions.append(handler)
  }
  
  /// Notifies all observers with the current value
  public func notify() {
    subscriptions.forEach { $0(value) }
  }
  
  /// Resets the validator
  public func reset() {
    value = initialValue
    isValid = nil
    error = nil
  }
}
