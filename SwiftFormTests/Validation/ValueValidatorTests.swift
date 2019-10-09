//
//  ValueValidatorTests.swift
//  SwiftFormTests
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import XCTest
@testable import SwiftForm

final class ValueValidatorTests: XCTestCase {
  
  var sut: ValueValidator<Int>!
  
  override func setUp() {
    sut = ValueValidator<Int>()
  }
  
  func testValidatorInitializer() {
    // Given
    let initialValue = 5
    
    // When
    sut = ValueValidator(value: initialValue)
    
    // Then
    XCTAssertEqual(sut.initialValue, initialValue, "Initial value should be the same that the one passed in initializer")
  }
  
  func testValidatorIsMandatoryAndValid() {
    // Given
    sut.isMandatory = true
    
    // When
    sut.value = 5
    sut.checkValidity()
    
    // Then
    let expected = true
    XCTAssertEqual(sut.isValid, expected, "Validator should be valid")
  }
  
  func testValidatorIsMandatoryAndNotValid() {
    // Given
    sut.isMandatory = true
    
    // When
    sut.value = nil
    sut.checkValidity()
    
    // Then
    let expected = false
    XCTAssertEqual(sut.isValid, expected, "Validator should not be valid")
  }
  
  func testValidatorIsNotMandatoryAndValid() {
    // Given
    sut.isMandatory = false
    
    // When
    sut.value = nil
    sut.checkValidity()
    
    // Then
    let expected = true
    XCTAssertEqual(sut.isValid, expected, "Validator should be valid")
  }
  
  func testValidatorChangesMandatoryStatus() {
    // Given
    sut.isMandatory = false
    sut.value = nil
    sut.checkValidity()
    
    // When
    sut.isMandatory = true
    
    // Then
    let expected = false
    XCTAssertEqual(sut.isValid ?? true, expected, "Validator should validates its value when mandatory status changes")
  }
  
  func testValidatorHasChanges() {
    // When
    sut.value = 5
    
    // Then
    let expected = true
    XCTAssertEqual(sut.hasChanges, expected, "Validator should have changes")
  }
  
  func testValidatorHasNoChanges() {
    // Given
    sut.value = 5
    
    // When
    sut.value = nil
    
    // Then
    let expected = false
    XCTAssertEqual(sut.hasChanges, expected, "Validator should not have changes")
  }
  
  func testValidatorErrorProvider() {
    // Given
    let errorProvider = ValueValidatorErrorProviderMock()
    sut.isMandatory = true
    sut.errorProvider = errorProvider
    
    // When
    sut.value = nil
    sut.checkValidity()
    
    // Then
    XCTAssertNotNil(sut.error, "Validator error should not be nil")
    XCTAssertEqual(sut.error, errorProvider.noValueError, "Validator should have a dedicated error")
  }
  
  func testValidatorSubscription() {
    // Given
    let expectation = self.expectation(description: "Subscription expectation")
    
    sut.subscribe { (_) in
      expectation.fulfill()
    }
    
    // When
    sut.notify()
    
    waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testValidatorDefaultValidationMethod() {
    // Given
    let expectation = self.expectation(description: "Subscription expectation")
    
    sut.subscribe { (_) in
      expectation.fulfill()
    }
    
    // When
    sut.validate(5)
    
    // Then
    let expected = true
    XCTAssertEqual(sut.hasChanges, expected, "Validator should have changes")
    XCTAssertEqual(sut.isValid ?? false, expected, "Validator should be valid")
    
    waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testValidatorReset() {
    // Given
    sut = ValueValidator(value: 10)
    
    // When
    sut.value = nil
    sut.checkValidity()
    sut.reset()
    
    // Then
    XCTAssertNil(sut.isValid, "Validator should not have validation state after reset")
    XCTAssertNil(sut.error, "Validator should not have error after reset")
  }
}
