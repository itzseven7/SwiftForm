//
//  ValidatorListTests.swift
//  SwiftFormTests
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import XCTest

final class ValidatorListTests: XCTestCase {
  
  var sut: DefaultValidatorList!
  var firstValidator: ValidatorMock!
  var secondValidator: ValidatorMock!
  var thirdValidator: ValidatorMock!
  
  override func setUp() {
    firstValidator = ValidatorMock()
    secondValidator = ValidatorMock()
    thirdValidator = ValidatorMock()
    
    sut = DefaultValidatorList()
    sut.items = [firstValidator, secondValidator, thirdValidator]
  }
  
  func testValidatorListHasChanges() {
    // Given
    firstValidator.shouldHaveChanges = true
    secondValidator.shouldHaveChanges = false
    
    // Then
    let expected = true
    XCTAssertEqual(sut.hasChanges, expected, "Validator list should have changes")
  }
  
  func testValidatorListIsValid() {
    // Given
    firstValidator.isMandatory = true
    firstValidator.shouldBeValid = true
    
    secondValidator.isMandatory = false
    secondValidator.shouldBeValid = true
    
    secondValidator.isMandatory = false
    
    // Then
    let expected = true
    XCTAssertEqual(sut.isValid, expected, "Validator list should be valid")
  }
  
  func testValidatorListIsNotValid() {
    // At least one mandatory is not valid
    
    // Given
    firstValidator.isMandatory = true
    firstValidator.shouldBeValid = false
    
    secondValidator.isMandatory = false
    secondValidator.shouldBeValid = true
    
    secondValidator.isMandatory = false
    
    // Then
    XCTAssertEqual(sut.isValid, false, "Validator list should not be valid")
    
    // At least one mandatory has no valid state
    
    // Given
    firstValidator.isMandatory = true
    firstValidator.shouldBeValid = nil
    
    secondValidator.isMandatory = false
    secondValidator.shouldBeValid = true
    
    secondValidator.isMandatory = false
    
    // Then
    XCTAssertEqual(sut.isValid, false, "Validator list should not be valid")
    
    // At least one non mandatory is not valid
    
    // Given
    
    firstValidator.isMandatory = true
    firstValidator.shouldBeValid = true
    
    secondValidator.isMandatory = false
    secondValidator.shouldBeValid = false
    
    secondValidator.isMandatory = false
    
    // Then
    XCTAssertEqual(sut.isValid, false, "Validator list should not be valid")
  }
  
  func testValidatorListCheckValidity() {
    // When
    sut.checkValidity()
    
    // Then
    let expected = true
    XCTAssertEqual(firstValidator.checkValidityIsCalled, expected, "Validator should check validity")
    XCTAssertEqual(secondValidator.checkValidityIsCalled, expected, "Validator should check validity")
    XCTAssertEqual(thirdValidator.checkValidityIsCalled, expected, "Validator should check validity")
  }
}
