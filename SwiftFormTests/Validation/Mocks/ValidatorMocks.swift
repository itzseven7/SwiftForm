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
  
  var isMandatory: Bool = true
  
  var shouldHaveChanges = false
  var hasChanges: Bool { return shouldHaveChanges }
  
  var checkValidityIsCalled = false
  
  func checkValidity() {
    checkValidityIsCalled = true
  }
}

class ValueValidatorMock<T: Equatable>: ValueValidator<T> {
  
  var shouldBeValid: Bool?
  override var isValid: Bool? {
    get {
      return shouldBeValid
    }
    
    set {
      shouldBeValid = newValue
    }
  }
  
  var shouldHaveChanges = false
  override var hasChanges: Bool {
    get {
      return shouldHaveChanges
    }
    
    set {
      shouldHaveChanges = newValue
    }
  }
  
  var validateIsCalled = false
  var subscribeIsCalled = false
  
  override func validate(_ value: T?) {
    super.validate(value)
    validateIsCalled = true
  }
  
  override func subscribe(_ handler: @escaping ((T?) -> Void)) {
    super.subscribe(handler)
    subscribeIsCalled = true
  }
  
  func resetMock() {
    validateIsCalled = false
    subscribeIsCalled = false
  }
}


