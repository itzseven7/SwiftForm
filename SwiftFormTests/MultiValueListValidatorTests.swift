//
//  MultiValueListValidatorTests.swift
//  SwiftFormTests
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import XCTest
@testable import SwiftForm

final class MultiValueListValidatorTests: XCTestCase {
  
  var sut: MultiValueListValidator<Int>!
  var errorProvider: MultiValueListValidatorErrorProviderMock!
  
  override func setUp() {
    sut = MultiValueListValidator(values: [2, 4, 6, 8, 10, 12])
    errorProvider = MultiValueListValidatorErrorProviderMock()
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
  
  func testValidatorIsInvalidWhenValueIsNotInList() {
    // Given
    sut.isMandatory = true
    
    // When
    sut.validate([2, 3])
    
    // Then
    let expected = false
    XCTAssertEqual(sut.isValid, expected, "Validator should not be valid")
    XCTAssertEqual(sut.error, errorProvider.valuesNotInListError, "Validator should have dedicated error")
  }
  
  func testValidatorIsInvalidWhenValueHasExcludedSubset() {
    // Given
    sut.isMandatory = true
    sut.excludedSubsets = [[4, 8]]
    
    // When
    sut.validate([2, 4, 6, 8])
    
    // Then
    let expected = false
    XCTAssertEqual(sut.isValid, expected, "Validator should not be valid")
    XCTAssertEqual(sut.error, errorProvider.valuesInExcludedSubsetError, "Validator should have dedicated error")
  }
}
