//
//  FormItemTests.swift
//  SwiftFormTests
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import XCTest
@testable import SwiftForm

final class FormItemTests: XCTestCase {
  
  var sut: FormItemMock = FormItemMock()
  
  // MARK: - Equality tests
  
  func testFormItemEquality() {
    // Given
    let formItem1 = FormItemMock()
    formItem1.indexPath = IndexPath(item: 0, section: 0)
    
    let formItem2 = FormItemMock()
    formItem2.indexPath = IndexPath(item: 1, section: 0)
    
    let formItem3 = FormItemMock()
    formItem3.indexPath = IndexPath(item: 0, section: 0)
    
    // Then
    XCTAssertNotEqual(formItem1, formItem2, "Form items should not be equal")
    XCTAssertEqual(formItem1, formItem3, "Form items should be equal")
  }
  
  // MARK: - State tests
  
  func testFormItemStateIsDisabled() {
    // Given
    sut.isEnabled = false
    
    // When
    let state = sut.state
    
    // Then
    let expected = FormItemState.disabled
    XCTAssertEqual(state, expected, "Form item should have disabled state")
  }
  
  func testFormItemStateIsEnabledAndHasNoValue() {
    // Given
    sut.isEnabled = true
    sut.validatorMock?.shouldBeValid = nil
    
    // When
    let state = sut.state
    
    // Then
    let expected = FormItemState.normal
    XCTAssertEqual(state, expected, "Form item should have normal state")
  }
  
  func testFormItemStateIsEnabledAndHasValue() {
    // Given
    sut.isEnabled = true
    sut.validatorMock?.shouldBeValid = true
    
    // When
    let state = sut.state
    
    // Then
    let expected = FormItemState.normal
    XCTAssertEqual(state, expected, "Form item should have normal state")
  }
  
  func testFormItemStateIsEditingWithoutValue() {
    // Given
    sut.isEnabled = true
    sut.isEditing = true
    sut.validatorMock?.shouldBeValid = nil
    
    // When
    let state = sut.state
    
    // Then
    let expected = FormItemState.editing
    XCTAssertEqual(state, expected, "Form item should have editing state")
  }
  
  func testFormItemStateIsEditingWithInvalidValue() {
    // Given
    sut.isEnabled = true
    sut.isEditing = true
    sut.validatorMock?.shouldBeValid = false
    
    // When
    let state = sut.state
    
    // Then
    let expected = FormItemState.error
    XCTAssertEqual(state, expected, "Form item should have error state")
  }
  
  func testFormItemStateIsInvalid() {
    // Given
    sut.isEnabled = true
    sut.isEditing = false
    sut.validatorMock?.shouldBeValid = false
    
    // When
    let state = sut.state
    
    // Then
    let expected = FormItemState.error
    XCTAssertEqual(state, expected, "Form item should have error state")
  }
}
