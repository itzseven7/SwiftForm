//
//  ListValidator.swift
//  CPA-ios
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation

protocol ListValidatorErrorProvider: ValueValidatorErrorProvider {
  
  /// Error when the value is not in the list
  var valueNotInListError: String? { get }
}

open class ListValidator<T: Equatable>: ValueValidator<T> {
  
  public var values: [T]
  
  private var listErrorProvider: ListValidatorErrorProvider? {
    return errorProvider as? ListValidatorErrorProvider
  }
  
  public init(value: T? = nil, values: [T]) {
    self.values = values
    super.init(value: value)
  }
  
  override public func checkValidity() {
    super.checkValidity()
    
    guard let value = value, isValid ?? false else {
      return
    }
    
    isValid = values.contains(value)
    error = isValid ?? false ? nil : listErrorProvider?.valueNotInListError
  }
}

protocol MultiValueListValidatorErrorProvider: ValueValidatorErrorProvider {
  
  var valuesNotInListError: String? { get }
  
  var valuesInExcludedSubsetError: String? { get }
}

open class MultiValueListValidator<T: Equatable>: ValueValidator<[T]> {
  public var values: [T]
  
  public var excludedSubsets: [[T]]?
  
  private var listErrorProvider: MultiValueListValidatorErrorProvider? {
    return errorProvider as? MultiValueListValidatorErrorProvider
  }
  
  public init(value: [T]? = nil, values: [T]) {
    self.values = values
    super.init(value: value)
  }
  
  override public func checkValidity() {
    super.checkValidity()
    
    guard let value = value, isValid ?? false else {
      return
    }
    
    let allValuesAreContained = value.filter { !values.contains($0) }.isEmpty
    
    guard allValuesAreContained else {
      error = listErrorProvider?.valuesNotInListError
      isValid = false
      return
    }
    
    excludedSubsets?.forEach { subset in
      
      var count = 0
      
      subset.forEach { subsetValue in
        if value.contains(subsetValue) {
          count = count + 1
        }
      }
      
      if count == subset.count {
        error = listErrorProvider?.valuesInExcludedSubsetError
        isValid = false
        return
      }
    }
  }
}
