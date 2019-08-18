//
//  BoundedValueValidatorTests.swift
//  SwiftFormTests
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import XCTest
@testable import SwiftForm

final class BoundedValueValidatorTests: XCTestCase {
  
  var sut: BoundedValueValidator<Int>!
  var errorProvider: BoundedValueValidatorErrorProviderMock!
  
  override func setUp() {
    sut = BoundedValueValidator()
    errorProvider = BoundedValueValidatorErrorProviderMock()
    sut.errorProvider = errorProvider
  }
  
  func testValidatorIsInvalidWithParentValidation() {
    // Given
    sut.isMandatory = true
    
    // When
    sut.validate(nil)
    
    // Then
    let expected = false
    XCTAssertEqual(sut.isValid, expected, "Validator should not be valid")
    XCTAssertEqual(sut.error, errorProvider.noValueError, "Validator should have dedicated error")
  }
  
  func testValidatorIsInvalidWhenValueIsLowerThanExcludedMinimumValue() {
    // Given
    sut.isMandatory = true
    sut.minimumValue = 10
    sut.minimumValueExcluded = true
    
    // When
    sut.validate(9)
    
    // Then
    let expected = false
    
    XCTAssertEqual(sut.isValid, expected, "Validator should not be valid")
    XCTAssertEqual(sut.error, errorProvider.lessThanMinimumValueError, "Validator should have dedicated error")
  }
  
  func testValidatorIsInvalidWhenValueIsLowerThanIncludedMinimumValue() {
    // Given
    sut.isMandatory = true
    sut.minimumValue = 10
    sut.minimumValueExcluded = false
    
    // When
    sut.validate(9)
    
    // Then
    let expected = false
    
    XCTAssertEqual(sut.isValid, expected, "Validator should not be valid")
    XCTAssertEqual(sut.error, errorProvider.lessThanMinimumValueError, "Validator should have dedicated error")
  }
  
  func testValidatorIsValidWhenValueIsEqualToIncludedMinimumValue() {
    // Given
    sut.isMandatory = true
    sut.minimumValue = 10
    sut.minimumValueExcluded = false
    
    // When
    sut.validate(10)
    
    // Then
    let expected = true
    
    XCTAssertEqual(sut.isValid, expected, "Validator should be valid")
  }
  
  func testValidatorIsInvalidWhenValueIsGreaterThanExcludedMaximumValue() {
    // Given
    sut.isMandatory = true
    sut.maximumValue = 10
    sut.maximumValueExcluded = true
    
    // When
    sut.validate(11)
    
    // Then
    let expected = false
    
    XCTAssertEqual(sut.isValid, expected, "Validator should be valid")
    XCTAssertEqual(sut.error, errorProvider.greaterThanMaximumValueError, "Validator should have dedicated error")
  }
  
  func testValidatorIsInvalidWhenValueIsGreaterThanIncludedMaximumValue() {
    // Given
    sut.isMandatory = true
    sut.maximumValue = 10
    sut.maximumValueExcluded = false
    
    // When
    sut.validate(11)
    
    // Then
    let expected = false
    
    XCTAssertEqual(sut.isValid, expected, "Validator should be valid")
    XCTAssertEqual(sut.error, errorProvider.greaterThanMaximumValueError, "Validator should have dedicated error")
  }
  
  func testValidatorIsValidWhenValueIsEqualToIncludedMaximumValue() {
    // Given
    sut.isMandatory = true
    sut.maximumValue = 10
    sut.minimumValueExcluded = false
    
    // When
    sut.validate(10)
    
    // Then
    let expected = true
    
    XCTAssertEqual(sut.isValid, expected, "Validator should be valid")
  }
}
