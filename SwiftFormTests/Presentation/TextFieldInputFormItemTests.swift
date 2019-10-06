//
//  TextFieldInputFormItemTests.swift
//  SwiftFormTests
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import XCTest
@testable import SwiftForm

final class TextFieldInputFormItemTestable: TextFieldInputFormItem<String> {
  var formatCallback: ((String?) -> String?)?
  var unformatCallback: ((String?) -> String?)?
  
  var validatorMock: ValueValidatorMock<String>? {
    return valueValidator as? ValueValidatorMock<String>
  }
  
  override func validator(_ value: String?) -> ValueValidator<String> {
    return ValueValidatorMock(value: value)
  }
  
  override func formatted(_ value: String?) -> String? {
    return formatCallback?(value)
  }
  
  override func unformatted(_ value: String?) -> String? {
    return unformatCallback?(value)
  }
}

final class TextFieldInputFormItemTests: XCTestCase {
  
  var sut = TextFieldInputFormItemTestable()
  
  var textField = UITextField()
  
  let window = UIWindow()
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    textField.delegate = self
    
    addTextField()
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func addTextField() {
    window.addSubview(textField)
    RunLoop.current.run(until: Date())
    textField.becomeFirstResponder()
  }
  
  func testTextFieldChangeEditingStatus() {
    // Given
    sut.validationMode = .returnKey
    
    // When
    textField.becomeFirstResponder()
    
    // Then
    XCTAssertTrue(sut.isEditing, "Text field form item should be in editing state")
    
    // When
    textField.resignFirstResponder()
    
    // Then
    XCTAssertFalse(sut.isEditing, "Text field form item should be in editing state")
  }
  
  func testTextFieldIsResignedIfFormItemValidatorIsValid() {
    // Given
    sut.validationMode = .returnKey
    sut.validatorMock?.shouldBeValid = true
    textField.becomeFirstResponder()
    
    // When
    textField.resignFirstResponder()
    
    // Then
    XCTAssertFalse(textField.isFirstResponder, "Text field should be resigned")
  }
  
  func testTextFieldIsStillActiveIfFormItemValidatorIsInvalid() {
    // Given
    sut.validationMode = .always
    sut.validatorMock?.shouldBeValid = false
    textField.becomeFirstResponder()
    
    // When
    textField.resignFirstResponder()
    
    // Then
    XCTAssertTrue(textField.isFirstResponder, "Text field should not be resigned")
  }
  
  func testFormItemMaximumCharacterCount() {
    // Given
    sut.maximumCharacters = 2
    textField.text = ""
    
    // When
    let shouldChangeFirstLetter = textField.delegate?.textField?(textField, shouldChangeCharactersIn: NSRange(location: 0, length: 0), replacementString: "a") ?? false
    textField.text = "a"
    let shouldChangeSecondLetter = textField.delegate?.textField?(textField, shouldChangeCharactersIn: NSRange(location: 1, length: 0), replacementString: "b") ?? false
    textField.text = "ab"
    let shouldChangeThirdLetter = textField.delegate?.textField?(textField, shouldChangeCharactersIn: NSRange(location: 2, length: 0), replacementString: "c") ?? true
    
    // Then
    XCTAssertTrue(shouldChangeFirstLetter, "")
    XCTAssertTrue(shouldChangeSecondLetter, "")
    XCTAssertFalse(shouldChangeThirdLetter, "")
  }
  
  func testFormItemFormatsTextField() {
    // Given
    sut.formatCallback = { value in
      return "\(value ?? "")!"
    }
    
    sut.unformatCallback = { value in
      return value?.replacingOccurrences(of: "!", with: "")
    }
    
    // When
    let _ = textField.delegate?.textField?(textField, shouldChangeCharactersIn: NSRange(location: 0, length: 0), replacementString: "a") ?? false
    
    // Then
    let expected = "a!"
    XCTAssertEqual(textField.text, expected, "Textfield text should be formatted")
    
    // When
    let _ = textField.delegate?.textField?(textField, shouldChangeCharactersIn: NSRange(location: 1, length: 0), replacementString: "b") ?? false
    
    // Then
    let expected2 = "ab!"
    XCTAssertEqual(textField.text, expected2, "Textfield text should be formatted")
  }
  
  func testFormItemClearsTextField() {
    // Given
    sut.clearButtonMode = .always
    sut.inputValue = "Test"
    textField.text = "Test"
    
    // When
    let _ = sut.textFieldShouldClear(textField)
    
    // Then
    let text: String? = textField.text?.isEmpty ?? true ? nil : textField.text
    
    XCTAssertNil(sut.inputValue)
    XCTAssertNil(text)
  }
  
  func testFormItemReturnKeyValidationMode() {
    // Given
    sut.validationMode = .returnKey
    
    // When
    let _ = sut.textFieldShouldReturn(textField)
    
    // Then
    XCTAssertTrue(sut.validatorMock?.validateIsCalled ?? false, "Form item should validate")
    
    sut.validatorMock?.resetMock()
    
    // When
    textField.resignFirstResponder()
    
    // Then
    XCTAssertFalse(sut.validatorMock?.validateIsCalled ?? true, "Form item should not validate")
  }
  
  func testFormItemAlwaysValidationMode() {
    // Given
    sut.validationMode = .always
    
    // When
    textField.resignFirstResponder()
    
    // Then
    XCTAssertTrue(sut.validatorMock?.validateIsCalled ?? true, "Form item should validate")
  }
}

extension TextFieldInputFormItemTests: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    sut.textFieldDidBeginEditing(textField)
  }
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    return sut.textFieldShouldEndEditing(textField)
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    sut.textFieldDidEndEditing(textField)
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    return sut.textField(textField, shouldChangeCharactersIn: range, replacementString:string)
  }
  
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    return sut.textFieldShouldClear(textField)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    return sut.textFieldShouldReturn(textField)
  }
}
