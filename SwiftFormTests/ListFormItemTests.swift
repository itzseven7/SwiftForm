//
//  ListFormItemTests.swift
//  SwiftFormTests
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import XCTest
@testable import SwiftForm

final class ListFormItemTests: XCTestCase {
  
  var sut: ListFormItem<Int>!
  var errorProvider: ListFormItemErrorProviderMock!
  
  override func setUp() {
    sut = ListFormItem(values: [2, 4, 6, 8])
    errorProvider = ListFormItemErrorProviderMock()
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
    sut.validator?(3)
    
    // Then
    let expected = false
    XCTAssertEqual(sut.isValid, expected, "Form item should not be valid")
    XCTAssertEqual(sut.error, errorProvider.valueNotInListError, "Form item should have dedicated error")
  }
}
