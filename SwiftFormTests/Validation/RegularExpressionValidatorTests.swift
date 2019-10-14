//
//  RegularExpressionValidatorTests.swift
//  SwiftFormTests
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import XCTest
@testable import SwiftForm

final class RegularExpressionValidatorTests: XCTestCase {
  
  var sut: RegularExpressionValidator!
  var errorProvider: RegularExpressionValidatorErrorProvider!
  
  let lowercaseRegex = ".*[a-z]+.*"
  let uppercaseRegex = ".*[A-Z]+.*"
  let digitRegex = ".*[0-9]+.*"
  
  override func setUp() {
    sut = RegularExpressionValidator(patterns: [lowercaseRegex, uppercaseRegex, digitRegex])
    errorProvider = RegularExpressionValidatorErrorProviderMock()
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
  
  func testValidatorIsInvalidWithMissingPattern() {
    // Given
    sut.isMandatory = true
    
    // When
    sut.validate("aAbBcCdD")
    
    // Then
    let expected = false
    XCTAssertEqual(sut.isValid, expected, "Validator should not be valid")
    XCTAssertEqual(sut.error, errorProvider.unmatchedPatternsError(for: [digitRegex]), "Validator should have dedicated error")
  }
}
