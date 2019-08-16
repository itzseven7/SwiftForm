//
//  FormMocks.swift
//  SwiftFormTests
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
@testable import SwiftForm

class DefaultForm: Form {
  var items: [FormItem] = []
}

class FormMock: Form {
  var items: [FormItem] = []
  
  var shouldBeValid = false
  var isValid: Bool? { return shouldBeValid }
  
  var shouldHaveChanges = false
  var hasChanges: Bool { return shouldHaveChanges }
  
  var checkValidityIsCalled = false
  
  func checkValidity() {
    checkValidityIsCalled = true
  }
}

class FormItemMock: FormItem {
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


