//
//  FormItemMocks.swift
//  SwiftFormTests
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation
@testable import SwiftForm

class FormItemMock: FormItem, Equatable {
  var validator: Validator = ValidatorMock()
  
  var validatorMock: ValidatorMock? {
    return validator as? ValidatorMock
  }
  
  var indexPath: IndexPath = IndexPath(row: 0, section: 0)
  
  var title: String?
  
  var description: String?
  
  var isEnabled: Bool = true
  
  var isHidden: Bool = false
  
  var isEditing: Bool = false
  
  var beginEditingCallback: (() -> Void)?
  
  var endEditingCallback: (() -> Void)?
  
  var focusOnNextItemCallback: ((FormItem) -> Void)?
  
  var validateIsCalled = false
  
  var beginEditingIsCalled = false
  var endEditingIsCalled = false
  var beginEditingCallbackIsCalled = false
  var endEditingCallbackIsCalled = false
  
  init() {
    beginEditingCallback = { [weak self] in
        self?.beginEditingCallbackIsCalled = true
    }
    
    endEditingCallback = { [weak self] in
      self?.endEditingCallbackIsCalled = true
    }
  }
  
  func beginEditing() {
    beginEditingIsCalled = true
  }
  
  func endEditing() {
    endEditingIsCalled = true
  }
  
  func validate() {
    validateIsCalled = true
  }
  
  var addObserverIsCalled = false
  
  func addObserver(_ observer: FormItemObserver) {
    addObserverIsCalled = true
  }
  
  func reset() {
    validateIsCalled = false
    beginEditingCallbackIsCalled = false
    endEditingCallbackIsCalled = false
    addObserverIsCalled = false
  }
}

final class FormItemObserverMock: FormItemObserver {
  var priority: Int = 1000
  
  var onValidationEventIsCalled = false
  var onValidationEventCallback: (() -> Void)?
  
  var onActivationEventIsCalled = false
  var onActivationEventCallback: (() -> Void)?
  
  var onEditingEventIsCalled = false
  var onEditingEventCallback: (() -> Void)?
  
  var onVisibilityEventIsCalled = false
  var onVisibilityEventCallback: (() -> Void)?
  
  var onRefreshEventIsCalled = false
  var onRefreshEventCallback: (() -> Void)?
  
  func onValidationEvent(formItem: FormItem) {
    onValidationEventIsCalled = true
    onValidationEventCallback?()
  }
  
  func onActivationEvent(formItem: FormItem) {
    onActivationEventIsCalled = true
    onActivationEventCallback?()
  }
  
  func onEditingEvent(formItem: FormItem) {
    onEditingEventIsCalled = true
    onEditingEventCallback?()
  }
  
  func onVisibilityEvent(formItem: FormItem) {
    onVisibilityEventIsCalled = true
    onVisibilityEventCallback?()
  }
  
  func onRefreshEvent(formItem: FormItem) {
    onRefreshEventIsCalled = true
    onRefreshEventCallback?()
  }
}
