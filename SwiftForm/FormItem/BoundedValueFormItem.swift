//
//  BoundedValueFormItem.swift
//  CPA-ios
//
//  Copyright © 2019 itzseven7. All rights reserved.
//

import Foundation

public protocol BoundedValueFormItemErrorProvider: FormItemErrorProvider {
  
  var lessThanLowerBoundError: String? { get }
  
  var greaterThanUpperBoundError: String? { get }
}

open class BoundedValueFormItem<T: Comparable>: BaseFormItem<T> {
  
  /// The lower bound of the value
  public var lowerBound: T?
  
  /// A boolean value which indicates if the form item should include the lower endpoint value into account while checking its validity, or not
  ///
  /// If set to true, the form item does not include the lower endpoint value into account
  public var hasOpenLowerBound = false
  
  /// The upper bound of the value
  public var upperBound: T?
  
  /// A boolean value which indicates if the form item should include the upper endpoint value into account while checking its validity, or not
  ///
  /// If set to true, the form item does not include the upper endpoint value into account
  public var hasOpenUpperBound = false
  
  private var boundedValueErrorProvider: BoundedValueFormItemErrorProvider? {
    return errorProvider as? BoundedValueFormItemErrorProvider
  }
  
  override public func checkValidity() {
    super.checkValidity()
    
    guard let value = value, isValid ?? false else {
      return
    }
    
    var boundedValueError: String?
    
    if let lowerBound = lowerBound {
      if hasOpenLowerBound && value <= lowerBound {
        isValid = false
        boundedValueError = boundedValueErrorProvider?.lessThanLowerBoundError
      } else if !hasOpenLowerBound && value < lowerBound {
        isValid = false
        boundedValueError = boundedValueErrorProvider?.lessThanLowerBoundError
      }
    }
    
    if let upperBound = upperBound {
      if hasOpenUpperBound && value >= upperBound {
        isValid = false
        boundedValueError = boundedValueErrorProvider?.greaterThanUpperBoundError
      } else if !hasOpenUpperBound && value > upperBound {
        isValid = false
        boundedValueError = boundedValueErrorProvider?.greaterThanUpperBoundError
      }
    }
    
    error = boundedValueError
  }
}
