//
//  BaseFormItemTests.swift
//  SwiftFormTests
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import XCTest
@testable import SwiftForm

final class BaseFormItemTests: XCTestCase {
  
  var sut: BaseFormItem<Int>!
  
  override func setUp() {
    sut = BaseFormItem<Int>()
  }
  
  func testFormItemInitializer() {
    // Given
    let initialValue = 5
    
    // When
    sut = BaseFormItem(value: initialValue)
    
    // Then
    XCTAssertEqual(sut.initialValue, initialValue, "Initial value should be the same that the one passed in initializer")
  }
  
  func testFormItemIsMandatoryAndValid() {
    // Given
    sut.isMandatory = true
    
    // When
    sut.value = 5
    sut.checkValidity()
    
    // Then
    let expected = true
    XCTAssertEqual(sut.isValid, expected, "Form item should be valid")
  }
  
  func testFormItemIsMandatoryAndNotValid() {
    // Given
    sut.isMandatory = true
    
    // When
    sut.value = nil
    sut.checkValidity()
    
    // Then
    let expected = false
    XCTAssertEqual(sut.isValid, expected, "Form item should not be valid")
  }
  
  func testFormItemIsNotMandatoryAndValid() {
    // Given
    sut.isMandatory = false
    
    // When
    sut.value = nil
    sut.checkValidity()
    
    // Then
    let expected = true
    XCTAssertEqual(sut.isValid, expected, "Form item should be valid")
  }
  
  func testFormItemChangesMandatoryStatus() {
    // Given
    sut.isMandatory = false
    sut.value = nil
    sut.checkValidity()
    
    // When
    sut.isMandatory = true
    
    // Then
    let expected = false
    XCTAssertEqual(sut.isValid ?? true, expected, "Form item should validates its value when mandatory status changes")
  }
  
  func testFormItemHasChanges() {
    // When
    sut.value = 5
    
    // Then
    let expected = true
    XCTAssertEqual(sut.hasChanges, expected, "Form item should have changes")
  }
  
  func testFormItemHasNoChanges() {
    // Given
    sut.value = 5
    
    // When
    sut.value = nil
    
    // Then
    let expected = false
    XCTAssertEqual(sut.hasChanges, expected, "Form item should not have changes")
  }
  
  func testFormItemErrorProvider() {
    // Given
    let errorProvider = FormItemErrorProviderMock()
    sut.isMandatory = true
    sut.errorProvider = errorProvider
    
    // When
    sut.value = nil
    sut.checkValidity()
    
    // Then
    XCTAssertNotNil(sut.error, "Form item error should not be nil")
    XCTAssertEqual(sut.error, errorProvider.noValueError, "Form item should have a dedicated error")
  }
  
  func testFormItemSubscription() {
    // Given
    let expectation = self.expectation(description: "Subscription expectation")
    
    sut.subscribe { (_) in
      expectation.fulfill()
    }
    
    // When
    sut.notify()
    
    waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testFormItemDefaultValidator() {
    // Given
    let expectation = self.expectation(description: "Subscription expectation")
    
    sut.subscribe { (_) in
      expectation.fulfill()
    }
    
    // When
    sut.validator?(5)
    
    // Then
    let expected = true
    XCTAssertEqual(sut.hasChanges, expected, "Form item should have changes")
    XCTAssertEqual(sut.isValid ?? false, expected, "Form item should be valid")
    
    waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testFormItemReset() {
    // Given
    sut = BaseFormItem(value: 10)
    
    // When
    sut.value = nil
    sut.checkValidity()
    sut.reset()
    
    // Then
    XCTAssertNil(sut.isValid, "Form item should not have validation state after reset")
    XCTAssertNil(sut.error, "Form item should not have error after reset")
  }
}
