//
//  TextFieldFormItemContainerTests.swift
//  SwiftFormTests
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import XCTest
@testable import SwiftForm

final class TextFieldFormItemContainerExample: TextFieldFormItemContainer {
  let textField = UITextField()
  
  var input: UITextField {
    return textField
  }
  
  var formItem: FormItem?
  
  func finishSetUp() {}
}

final class TextFieldFormItemContainerTests: XCTestCase {
  
  var sut = TextFieldFormItemContainerExample()
  var formItem: TextFieldInputFormItem<String>!
  var valueValidator = ValueValidatorMock<String>()
  
  let window = UIWindow()
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    formItem = TextFieldInputFormItem(validator: valueValidator)
    sut.formItem = formItem
    
    addTextField()
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func addTextField() {
    window.addSubview(sut.textField)
    RunLoop.current.run(until: Date())
  }
  
  func testBeginEditingCallbackIsCorrectlySet() {
    // Given
    sut.setUp()
    
    // When
    formItem.beginEditingCallback?()
    
    // Then
    XCTAssertTrue(sut.textField.isFirstResponder, "Textfield should be editing")
  }
  
  func testEndEditingCallbackIsCorrectlySet() {
    // Given
    sut.setUp()
    
    // When
    formItem.endEditingCallback?()
    
    // Then
    XCTAssertFalse(sut.textField.isFirstResponder, "Textfield should not be editing")
  }
  
  func testBinding() {
    // Given
    formItem.valueValidator.value = "Test"
    formItem.isSecureTextEntry = true
    
    // When
    sut.bind()
    
    // Then
    XCTAssertEqual(sut.textField.text, formItem.valueValidator.value)
    XCTAssertEqual(sut.textField.isSecureTextEntry, formItem.isSecureTextEntry)
  }
}
