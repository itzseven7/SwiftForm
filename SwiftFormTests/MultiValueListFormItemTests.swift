//
//  MultiValueListFormItemTests.swift
//  SwiftFormTests
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import XCTest
@testable import SwiftForm

final class MultiValueListFormItemTests: XCTestCase {
  
  var sut: MultiValueListFormItem<Int>!
  var errorProvider: MultiValueListFormItemErrorProviderMock!
  
  override func setUp() {
    sut = MultiValueListFormItem(values: [2, 4, 6, 8, 10, 12])
    errorProvider = MultiValueListFormItemErrorProviderMock()
    sut.errorProvider = errorProvider
  }
  
  func testFormItemIsInvalidWithParentValidation() {
    // Given
    sut.isMandatory = true
    
    // When
    sut.validator?(nil)
    
    // Then
    let expected = false
    XCTAssertEqual(sut.isValid, expected, "Form item should not be valid")
    XCTAssertEqual(sut.error, errorProvider.noValueError, "Form item should have dedicated error")
  }
  
  func testFormItemIsInvalidWhenValueIsNotInList() {
    // Given
    sut.isMandatory = true
    
    // When
    sut.validator?([2, 3])
    
    // Then
    let expected = false
    XCTAssertEqual(sut.isValid, expected, "Form item should not be valid")
    XCTAssertEqual(sut.error, errorProvider.valuesNotInListError, "Form item should have dedicated error")
  }
  
  func testFormItemIsInvalidWhenValueHasExcludedSubset() {
    // Given
    sut.isMandatory = true
    sut.excludedSubsets = [[4, 8]]
    
    // When
    sut.validator?([2, 4, 6, 8])
    
    // Then
    let expected = false
    XCTAssertEqual(sut.isValid, expected, "Form item should not be valid")
    XCTAssertEqual(sut.error, errorProvider.valuesInExcludedSubsetError, "Form item should have dedicated error")
  }
}
