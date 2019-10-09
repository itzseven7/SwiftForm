//
//  BaseFormTests.swift
//  SwiftFormTests
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import XCTest
@testable import SwiftForm

final class BaseFormTests: XCTestCase {
  
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
  }
  
  func testDefaultValidatorListCreationOnSectionsAssignment() {
    // When
    sut.sections = [firstSection, secondSection]
    
    // Then
    let expected = firstSection.items.count + secondSection.items.count
    XCTAssertEqual(sut.validator.items.count, expected, "Validator list item count should match with sections item count")
  }
  
  func testItemsAreObservedOnSectionsAssignment() {
    // When
    sut.sections = [firstSection, secondSection]
    
    // Then
    let expected = true
    
    sut.sections.flatMap { $0.items }.compactMap { $0 as? FormItemMock }.forEach {
      XCTAssertEqual($0.addObserverIsCalled, expected, "Form item should have the form as an observer")
    }
  }
  
  func testItemsIndexPathAreCorrectOnSectionsAssignment() {
    // When
    sut.sections = [firstSection, secondSection]
    
    // Then
    XCTAssertEqual(firstItem.indexPath, IndexPath(item: 0, section: 0), "Form item index path should be set correctly")
    XCTAssertEqual(secondItem.indexPath, IndexPath(item: 1, section: 0), "Form item index path should be set correctly")
    XCTAssertEqual(thirdItem.indexPath, IndexPath(item: 0, section: 1), "Form item index path should be set correctly")
  }
  
  func testHiddenSectionsAreFilteredOut() {
    // Given
    sut.sections = [firstSection, secondSection]
    secondSection.isHidden = true
    
    // Then
    let expected = 1
    XCTAssertEqual(sut.sections.count, expected)
  }
  
  func testIsEnabledChangeImpactAllItems() {
    // Given
    firstItem.isEnabled = true
    secondItem.isEnabled = false
    thirdItem.isEnabled = true
    
    // When
    sut.isEnabled = false
    
    // Then
    let expected = false
    sut.sections.flatMap { $0.items }.forEach { XCTAssertEqual($0.isEnabled, expected, "Form item should have the same activation state than the form")}
  }
  
  // MARK: - FormItemObserver default conformance
  
  func testItemValidationCallsDelegateAndFocus() {
    // Given
    let delegate = FormDelegateMock()
    sut.delegate = delegate
    
    // When
    sut.onValidationEvent(formItem: firstItem)
    
    // Then
    let expected = true
    XCTAssertEqual(delegate.formItemsDidUpdateIsCalled, expected, "Delegate method should be called by default")
  }
  
  func testItemVisibilityChangeCallsDelegate() {
    // Given
    let delegate = FormDelegateMock()
    sut.delegate = delegate
    
    // When
    firstItem.isHidden = true
    sut.onVisibilityEvent(formItem: firstItem)
    
    // Then
    let expected = true
    XCTAssertEqual(delegate.formItemsDidHideIsCalled, expected)
    
    delegate.reset()
    
    // When
    firstItem.isHidden = false
    sut.onVisibilityEvent(formItem: firstItem)
    
    // Then
    XCTAssertEqual(delegate.formItemsDidBecomeVisibleIsCalled, expected)
  }
}
