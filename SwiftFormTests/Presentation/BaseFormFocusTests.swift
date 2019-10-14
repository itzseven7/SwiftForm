//
//  BaseFormFocusTests.swift
//  SwiftFormTests
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import XCTest
@testable import SwiftForm

final class BaseFormFocusTests: XCTestCase {
  
  var sut: BaseForm!
  
  var firstSection: FormSectionMock!
  var secondSection: FormSectionMock!
  
  var firstItem: FormItemMock!
  var secondItem: FormItemMock!
  var thirdItem: FormItemMock!
  
  override func setUp() {
    sut = BaseForm()
    
    firstSection = FormSectionMock()
    
    firstItem = FormItemMock()
    
    secondItem = FormItemMock()
    
    thirdItem = FormItemMock()
    
    firstSection.items = [firstItem, secondItem]
    
    secondSection = FormSectionMock()
    
    secondSection.items = [thirdItem]
    
    sut.sections = [firstSection, secondSection]
  }
  
  func testEditingStateIsCorrectlyHandled() {
    // Given
    sut.focusableItems = [.any]
    
    firstItem.isEditing = true
    
    // When
    sut.focusOnNextItem()
    
    // Then
    let expected = true
    
    XCTAssertEqual(firstItem.endEditingIsCalled, expected, "First item end editing callback should be called")
    XCTAssertEqual(secondItem.beginEditingIsCalled, expected, "Second item begin editing callback should be called")
  }
  
  func testFocusIsDisabled() {
    // Given
    sut.focusableItems = []
    
    firstItem.isEditing = true
    
    // When
    sut.focusOnNextItem()
    
    // Then
    let expected = false
    XCTAssertEqual(firstItem.beginEditingIsCalled, expected, "Form item begin editing callback should not be called")
    XCTAssertEqual(secondItem.beginEditingIsCalled, expected, "Form item begin editing callback should not be called")
    XCTAssertEqual(thirdItem.beginEditingIsCalled, expected, "Form item begin editing callback should not be called")
  }
  
  func testFocusOnOptionalItem() {
    // Given
    sut.focusableItems = [.optional]
    
    firstItem.isEditing = true
    
    thirdItem.validator.isMandatory = false
    
    // When
    sut.focusOnNextItem()
    
    // Then
    let expected = thirdItem.indexPath
    XCTAssertEqual(sut.editingFormItem?.indexPath, expected, "Form item should be editing")
  }
  
  func testFocusOnMandatoryItem() {
    // Given
    sut.focusableItems = [.mandatory]
    
    firstItem.isEditing = true
    secondItem.validator.isMandatory = false
    thirdItem.validator.isMandatory = true
    
    // When
    sut.focusOnNextItem()
    
    // Then
    let expected = thirdItem.indexPath
    XCTAssertEqual(sut.editingFormItem?.indexPath, expected, "Form item should be editing")
  }
  
  func testFocusOnInvalidItem() {
    // Given
    sut.focusableItems = [.invalid]
    
    firstItem.isEditing = true
    thirdItem.validatorMock?.shouldBeValid = false
    
    // When
    sut.focusOnNextItem()
    
    // Then
    let expected = thirdItem.indexPath
    XCTAssertEqual(sut.editingFormItem?.indexPath, expected, "Form item should be editing")
  }
  
  func testFocusOnAnyItem() {
    // Given
    sut.focusableItems = [.any]
    
    firstItem.isEditing = true
    secondItem.validator.isMandatory = false
    secondItem.validatorMock?.shouldBeValid = false
    thirdItem.validator.isMandatory = false
    
    // When
    sut.focusOnNextItem()
    
    // Then
    let expected = thirdItem.indexPath
    XCTAssertEqual(sut.editingFormItem?.indexPath, expected, "Form item should be editing")
  }
  
  func testFocusOnAllItem() {
    // Given
    sut.focusableItems = [.all]
    
    firstItem.isEditing = true
    
    thirdItem.validator.isMandatory = false
    
    // When
    sut.focusOnNextItem()
    
    // Then
    let expected = secondItem.indexPath
    XCTAssertEqual(sut.editingFormItem?.indexPath, expected, "Form item should be editing")
  }
  
  // MARK: - Type priority
  
  func testInvalidItemWillBeFoundFirst() {
    // Given
    sut.focusableItems = [.all]
    
    firstItem.isEditing = true
    secondItem.validatorMock?.isMandatory = false
    thirdItem.validatorMock?.shouldBeValid = false
    
    // When
    sut.focusOnNextItem()
    
    // Then
    let expected = thirdItem.indexPath
    XCTAssertEqual(sut.editingFormItem?.indexPath, expected, "Form item should be editing")
  }
  
  func testMandatoryItemWillBeFoundSecond() {
    // Given
    sut.focusableItems = [.any]
    
    firstItem.isEditing = true
    secondItem.validatorMock?.isMandatory = false
    
    // When
    sut.focusOnNextItem()
    
    // Then
    let expected = thirdItem.indexPath
    XCTAssertEqual(sut.editingFormItem?.indexPath, expected, "Form item should be editing")
  }
}
