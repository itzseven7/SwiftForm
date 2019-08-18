//
//  ValidatorMocks.swift
//  SwiftFormTests
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
@testable import SwiftForm

class DefaultValidatorList: ValidatorList {
  var items: [Validator] = []
}

class ValidatorListMock: ValidatorList {
  var items: [Validator] = []
  
  var shouldBeValid = false
  var isValid: Bool? { return shouldBeValid }
  
  var shouldHaveChanges = false
  var hasChanges: Bool { return shouldHaveChanges }
  
  var checkValidityIsCalled = false
  
  func checkValidity() {
    checkValidityIsCalled = true
  }
}

class ValidatorMock: Validator {
  var error: String?
  
  var shouldBeValid: Bool?
  var isValid: Bool? { return shouldBeValid }
  
  var isMandatory: Bool = false
  
  var shouldHaveChanges = false
  var hasChanges: Bool { return shouldHaveChanges }
  
  var checkValidityIsCalled = false
  
  func checkValidity() {
    checkValidityIsCalled = true
  }
}


