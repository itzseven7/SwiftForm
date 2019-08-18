//
//  TextValidatorTests.swift
//  SwiftFormTests
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import XCTest
@testable import SwiftForm

final class TextValidatorTests: XCTestCase {
  
  var sut: TextValidator!
  var errorProvider: TextValidatorErrorProviderMock!
  
  override func setUp() {
    sut = TextValidator()
    errorProvider = TextValidatorErrorProviderMock()
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
  
  func testValidatorIsInvalidWhenValueIsEmpty() {
    // Given
    let value1 = "      "
    let value2 = """


    """
    
    // When
    sut.validate(value1)
    
    // Then
    let expected = false
    XCTAssertEqual(sut.isValid, expected, "Validator should not be valid")
    XCTAssertEqual(sut.error, errorProvider.emptyError, "Validator should have dedicated error")
    
    // When
    sut.validate(value2)
    XCTAssertEqual(sut.isValid, expected, "Validator should not be valid")
    XCTAssertEqual(sut.error, errorProvider.emptyError, "Validator should have dedicated error")
  }
}
