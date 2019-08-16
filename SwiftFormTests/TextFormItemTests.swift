//
//  TextFormItemTests.swift
//  SwiftFormTests
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import XCTest
@testable import SwiftForm

final class TextFormItemTests: XCTestCase {
  
  var sut: TextFormItem!
  var errorProvider: TextFormItemErrorProviderMock!
  
  override func setUp() {
    sut = TextFormItem()
    errorProvider = TextFormItemErrorProviderMock()
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
  
  func testFormItemIsInvalidWhenValueIsEmpty() {
    // Given
    let value1 = "      "
    let value2 = """


    """
    
    // When
    sut.validator?(value1)
    
    // Then
    let expected = false
    XCTAssertEqual(sut.isValid, expected, "Form item should not be valid")
    XCTAssertEqual(sut.error, errorProvider.emptyError, "Form item should have dedicated error")
    
    // When
    sut.validator?(value2)
    XCTAssertEqual(sut.isValid, expected, "Form item should not be valid")
    XCTAssertEqual(sut.error, errorProvider.emptyError, "Form item should have dedicated error")
  }
}
