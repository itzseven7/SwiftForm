//
//  ListFormItem.swift
//  CPA-ios
//
//  Copyright © 2019 itzseven7. All rights reserved.
//

import Foundation

protocol ListFormItemErrorProvider: FormItemErrorProvider {
  
  /// Error when the value is not in the list
  var valueNotInListError: String? { get }
}

open class ListFormItem<T: Equatable>: BaseFormItem<T> {
  
  public var values: [T]
  
  private var listErrorProvider: ListFormItemErrorProvider? {
    return errorProvider as? ListFormItemErrorProvider
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

protocol MultiValueListFormItemErrorProvider: FormItemErrorProvider {
  
  var valuesNotInListError: String? { get }
  
  var valuesInExcludedSubsetError: String? { get }
}

open class MultiValueListFormItem<T: Equatable>: BaseFormItem<[T]> {
  public var values: [T]
  
  public var excludedSubsets: [[T]]?
  
  private var listErrorProvider: MultiValueListFormItemErrorProvider? {
    return errorProvider as? MultiValueListFormItemErrorProvider
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
