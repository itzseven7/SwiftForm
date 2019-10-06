//
//  ListValidatorTests.swift
//  SwiftFormTests
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import XCTest
@testable import SwiftForm

final class ListValidatorTests: XCTestCase {
  
  var sut: ListValidator<Int>!
  var errorProvider: ListValidatorErrorProviderMock!
  
  override func setUp() {
    sut = ListValidator(values: [2, 4, 6, 8])
    errorProvider = ListValidatorErrorProviderMock()
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
    sut.validate(3)
    
    // Then
    let expected = false
    XCTAssertEqual(sut.isValid, expected, "Validator should not be valid")
    XCTAssertEqual(sut.error, errorProvider.valueNotInListError, "Validator should have dedicated error")
  }
}
