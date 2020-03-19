//
//  FormMocks.swift
//  SwiftFormTests
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
@testable import SwiftForm

class DefaultForm: Form {
  var validator: ValidatorList
  
  var sections: [FormSection] = []
  
  var formDelegate: FormDelegate?
  
  var isEnabled: Bool = true
  
  init(validator: ValidatorList = ValidatorListMock()) {
    self.validator = validator
  }
}

class FormDelegateMock: FormDelegate {
  var formSectionsDidBecomeVisibleIsCalled = false
  
  func formSectionsDidBecomeVisible(_ formSections: [FormSection]) {
    formSectionsDidBecomeVisibleIsCalled = true
  }
  
  var formSectionsDidHideIsCalled = false
  
  func formSectionsDidHide(_ formSections: [FormSection]) {
    formSectionsDidHideIsCalled = true
  }
  
  var formItemsDidUpdateIsCalled = false
  
  func formItemsDidUpdate(_ formItems: [FormItem]) {
    formItemsDidUpdateIsCalled = true
  }
  
  var formItemsDidBecomeVisibleIsCalled = false
  
  func formItemsDidBecomeVisible(_ formItems: [FormItem]) {
    formItemsDidBecomeVisibleIsCalled = true
  }
  
  var formItemsDidHideIsCalled = false
  
  func formItemsDidHide(_ formItems: [FormItem]) {
    formItemsDidHideIsCalled = true
  }
  
  func reset() {
    formSectionsDidBecomeVisibleIsCalled = false
    formSectionsDidHideIsCalled = false
    formItemsDidUpdateIsCalled = false
    formItemsDidBecomeVisibleIsCalled = false
    formItemsDidHideIsCalled = false
  }
}
