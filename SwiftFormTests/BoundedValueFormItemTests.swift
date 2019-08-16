//
//  BoundedValueFormItemTests.swift
//  SwiftFormTests
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import XCTest
@testable import SwiftForm

final class BoundedValueFormItemTests: XCTestCase {
  
  var sut: BoundedValueFormItem<Int>!
  var errorProvider: BoundedValueFormItemErrorProviderMock!
  
  override func setUp() {
    sut = BoundedValueFormItem()
    errorProvider = BoundedValueFormItemErrorProviderMock()
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
  
  func testFormItemIsInvalidWhenValueIsLowerThanOpenLowerBound() {
    // Given
    sut.isMandatory = true
    sut.lowerBound = 10
    sut.hasOpenLowerBound = true
    
    // When
    sut.validator?(9)
    
    // Then
    let expected = false
    
    XCTAssertEqual(sut.isValid, expected, "Form item should not be valid")
    XCTAssertEqual(sut.error, errorProvider.lessThanLowerBoundError, "Form item should have dedicated error")
  }
  
  func testFormItemIsInvalidWhenValueIsLowerThanNonOpenedLowerBound() {
    // Given
    sut.isMandatory = true
    sut.lowerBound = 10
    sut.hasOpenLowerBound = false
    
    // When
    sut.validator?(9)
    
    // Then
    let expected = false
    
    XCTAssertEqual(sut.isValid, expected, "Form item should not be valid")
    XCTAssertEqual(sut.error, errorProvider.lessThanLowerBoundError, "Form item should have dedicated error")
  }
  
  func testFormItemIsValidWhenValueIsEqualToNonOpenedLowerBound() {
    // Given
    sut.isMandatory = true
    sut.lowerBound = 10
    sut.hasOpenLowerBound = false
    
    // When
    sut.validator?(10)
    
    // Then
    let expected = true
    
    XCTAssertEqual(sut.isValid, expected, "Form item should be valid")
  }
  
  func testFormItemIsInvalidWhenValueIsGreaterThanOpenedUpperBound() {
    // Given
    sut.isMandatory = true
    sut.upperBound = 10
    sut.hasOpenUpperBound = true
    
    // When
    sut.validator?(11)
    
    // Then
    let expected = false
    
    XCTAssertEqual(sut.isValid, expected, "Form item should be valid")
    XCTAssertEqual(sut.error, errorProvider.greaterThanUpperBoundError, "Form item should have dedicated error")
  }
  
  func testFormItemIsInvalidWhenValueIsGreaterThanNonOpenedUpperBound() {
    // Given
    sut.isMandatory = true
    sut.upperBound = 10
    sut.hasOpenUpperBound = false
    
    // When
    sut.validator?(11)
    
    // Then
    let expected = false
    
    XCTAssertEqual(sut.isValid, expected, "Form item should be valid")
    XCTAssertEqual(sut.error, errorProvider.greaterThanUpperBoundError, "Form item should have dedicated error")
  }
  
  func testFormItemIsValidWhenValueIsEqualToNonOpenedUpperBound() {
    // Given
    sut.isMandatory = true
    sut.upperBound = 10
    sut.hasOpenLowerBound = false
    
    // When
    sut.validator?(10)
    
    // Then
    let expected = true
    
    XCTAssertEqual(sut.isValid, expected, "Form item should be valid")
  }
}
