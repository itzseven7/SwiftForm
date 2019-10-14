//
//  InputFormItemTests.swift
//  SwiftFormTests
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import XCTest
@testable import SwiftForm

final class InputFormItemTests: XCTestCase {
  
  var sut: InputFormItem<String, String>!
  var validator = ValueValidatorMock<String>()
  
  override func setUp() {
    sut = InputFormItem(validator: validator)
  }
  
  func testFormItemValidate() {
    // Given
    sut.isEnabled = false
    sut.isHidden = false
    
    // When
    sut.validate()
    
    // Then
    XCTAssertFalse(validator.validateIsCalled, "Validator validate method should not be called")
    
    // Given
    sut.isEnabled = true
    sut.isHidden = true
    
    // When
    sut.validate()
    
    // Then
    XCTAssertFalse(validator.validateIsCalled, "Validator validate method should not be called")
    
    // Given
    sut.isEnabled = true
    sut.isHidden = false
    
    // When
    sut.validate()
    
    // Then
    XCTAssertTrue(validator.validateIsCalled, "Validator validate method should be called")
  }
  
  func testFormItemValueConversionsWithSameType() {
    // Given
    let initialValue = "Value"
    let initialInputValue = "Input value"
    
    // When
    let convertedValue = sut.value(from: initialInputValue)
    let convertedInputValue = sut.inputValue(from: initialValue)
    
    // Then
    XCTAssertEqual(convertedValue, initialInputValue, "Converted value should match with input value")
    XCTAssertEqual(convertedInputValue, initialValue, "Converted input value should match with value")
  }
  
  func testFormItemNotifyObservers() {
    // Given
    let observer = FormItemObserverMock()
    
    sut.addObserver(observer)
    
    // When
    sut.notifyValidationChange()
    
    // Then
    let expected = true
    XCTAssertEqual(observer.onValidationEventIsCalled, expected, "Observer should be called on notify")
  }
  
  func testFormItemNotifyObserversWithPriority() {
    // Given
    var firstDate: Date!
    var secondDate: Date!
    
    let observer1 = FormItemObserverMock()
    observer1.priority = 5
    observer1.onValidationEventCallback = {
      firstDate = Date()
    }
    
    let observer2 = FormItemObserverMock()
    observer2.priority = 10
    observer2.onValidationEventCallback = {
      secondDate = Date()
    }
    
    sut.addObserver(observer1)
    sut.addObserver(observer2)
    
    // When
    sut.notifyValidationChange()
    
    // Then
    XCTAssertTrue(firstDate > secondDate, "Observer with higher priority should be called first")
  }
}
