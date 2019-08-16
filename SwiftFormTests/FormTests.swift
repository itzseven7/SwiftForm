//
//  FormTests.swift
//  SwiftFormTests
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import XCTest

final class FormTests: XCTestCase {
  
  var sut: DefaultForm!
  var firstFormItem: FormItemMock!
  var secondFormItem: FormItemMock!
  var thirdFormItem: FormItemMock!
  
  override func setUp() {
    firstFormItem = FormItemMock()
    secondFormItem = FormItemMock()
    thirdFormItem = FormItemMock()
    
    sut = DefaultForm()
    sut.items = [firstFormItem, secondFormItem, thirdFormItem]
  }
  
  func testFormHasChanges() {
    // Given
    firstFormItem.shouldHaveChanges = true
    secondFormItem.shouldHaveChanges = false
    
    // Then
    let expected = true
    XCTAssertEqual(sut.hasChanges, expected, "Form should have changes")
  }
  
  func testFormIsValid() {
    // Given
    firstFormItem.isMandatory = true
    firstFormItem.shouldBeValid = true
    
    secondFormItem.isMandatory = false
    secondFormItem.shouldBeValid = true
    
    secondFormItem.isMandatory = false
    
    // Then
    let expected = true
    XCTAssertEqual(sut.isValid, expected, "Form should be valid")
  }
  
  func testFormIsNotValid() {
    // At least one mandatory is not valid
    
    // Given
    firstFormItem.isMandatory = true
    firstFormItem.shouldBeValid = false
    
    secondFormItem.isMandatory = false
    secondFormItem.shouldBeValid = true
    
    secondFormItem.isMandatory = false
    
    // Then
    XCTAssertEqual(sut.isValid, false, "Form should not be valid")
    
    // At least one mandatory has no valid state
    
    // Given
    firstFormItem.isMandatory = true
    firstFormItem.shouldBeValid = nil
    
    secondFormItem.isMandatory = false
    secondFormItem.shouldBeValid = true
    
    secondFormItem.isMandatory = false
    
    // Then
    XCTAssertEqual(sut.isValid, false, "Form should not be valid")
    
    // At least one non mandatory is not valid
    
    // Given
    
    firstFormItem.isMandatory = true
    firstFormItem.shouldBeValid = true
    
    secondFormItem.isMandatory = false
    secondFormItem.shouldBeValid = false
    
    secondFormItem.isMandatory = false
    
    // Then
    XCTAssertEqual(sut.isValid, false, "Form should not be valid")
  }
  
  func testFormCheckValidity() {
    // When
    sut.checkValidity()
    
    // Then
    let expected = true
    XCTAssertEqual(firstFormItem.checkValidityIsCalled, expected, "Form item should check validity")
    XCTAssertEqual(secondFormItem.checkValidityIsCalled, expected, "Form item should check validity")
    XCTAssertEqual(thirdFormItem.checkValidityIsCalled, expected, "Form item should check validity")
  }
}
