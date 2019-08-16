//
//  RegularExpressionFormItemTests.swift
//  SwiftFormTests
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import XCTest
@testable import SwiftForm

final class RegularExpressionFormItemTests: XCTestCase {
  
  var sut: RegularExpressionFormItem!
  var errorProvider: RegularExpressionFormItemErrorProvider!
  
  let lowercaseRegex = ".*[a-z]+.*"
  let uppercaseRegex = ".*[A-Z]+.*"
  let digitRegex = ".*[0-9]+.*"
  
  override func setUp() {
    sut = RegularExpressionFormItem(patterns: [lowercaseRegex, uppercaseRegex, digitRegex])
    errorProvider = RegularExpressionFormItemErrorProviderMock()
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
  
  func testFormItemIsInvalidWithMissingPattern() {
    // Given
    sut.isMandatory = true
    
    // When
    sut.validator?("aAbBcCdD")
    
    // Then
    let expected = false
    XCTAssertEqual(sut.isValid, expected, "Form item should not be valid")
    XCTAssertEqual(sut.error, errorProvider.unmatchedPatternsError(for: [digitRegex]), "Form item should have dedicated error")
  }
}
