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
  
  private var subscriptions: [((ValueType?) -> Void)] = []
  
  /// Initializes a new validator
  ///
  /// - Parameter value: the initial value
  public init(value: ValueType? = nil) {
    self.value = value
    self.initialValue = value
    
    if value != nil {
      checkValidity()
    }
  }
  
  public func validate(_ value: ValueType?) {
    self.value = value
    checkValidity()
    notify()
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
    subscriptions.append(handler)
  }
  
  /// Notifies all observers
  internal func notify() {
    subscriptions.forEach { $0(value) }
  }
  
  /// Resets the validator
  public func reset() {
    value = initialValue
    isValid = nil
    error = nil
  }
}
