//
//  BoundedValueValidator.swift
//  CPA-ios
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation

public protocol BoundedValueValidatorErrorProvider: ValueValidatorErrorProvider {
  
  var lessThanMinimumValueError: String? { get }
  
  var greaterThanMaximumValueError: String? { get }
}

open class BoundedValueValidator<T: Comparable>: ValueValidator<T> {
  
  /// The minimum value
  public var minimumValue: T?
  
  public var minimumValueExcluded = false
  
  /// The maximum value
  public var maximumValue: T?
  
  /// A boolean value which indicates if the validator should include the upper endpoint value into account while checking its validity, or not
  ///
  /// If set to true, the validator does not include the upper endpoint value into account
  public var maximumValueExcluded = false
  
  private var boundedValueErrorProvider: BoundedValueValidatorErrorProvider? {
    return errorProvider as? BoundedValueValidatorErrorProvider
  }
  
  override public func checkValidity() {
    super.checkValidity()
    
    guard let value = value, isValid ?? false else {
      return
    }
    
    var boundedValueError: String?
    
    if let minValue = minimumValue {
      if minimumValueExcluded && value <= minValue {
        isValid = false
        boundedValueError = boundedValueErrorProvider?.lessThanMinimumValueError
      } else if !minimumValueExcluded && value < minValue {
        isValid = false
        boundedValueError = boundedValueErrorProvider?.lessThanMinimumValueError
      }
    }
    
    if let maxValue = maximumValue {
      if maximumValueExcluded && value >= maxValue {
        isValid = false
        boundedValueError = boundedValueErrorProvider?.greaterThanMaximumValueError
      } else if !maximumValueExcluded && value > maxValue {
        isValid = false
        boundedValueError = boundedValueErrorProvider?.greaterThanMaximumValueError
      }
    }
    
    error = boundedValueError
  }
}
