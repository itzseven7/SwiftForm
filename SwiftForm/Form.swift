//
//  Form.swift
//  SwiftForm
//
//  Created by Romain on 16/08/2019.
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation

protocol Form {
  var validator: ValidatorList { get }
  
  var sections: [FormSection] { get }
  
  var delegate: FormDelegate? { get set }
}

extension Form {
  var allItems: [FormItem] {
    return sections.flatMap { $0.items }.filter { !$0.isHidden }
  }
  
  var editingFormItem: FormItem? {
    return sections.flatMap { $0.items }.filter { $0.isEditing }.first
  }
  
  func formItem(at indexPath: IndexPath) -> FormItem? {
    guard indexPath.section < sections.count, indexPath.item < sections[indexPath.section].items.count else {
      return nil
    }
    
    return sections[indexPath.section].items[indexPath.item]
  }
}

protocol FormDelegate: class {
  
  func formSectionsDidBecomeVisible(_ formSections: [FormSection])
  func formSectionsDidHide(_ formSections: [FormSection])
  
  func formItemsDidUpdate(_ formItems: [FormItem]) // maybe another method to tell the form that the update is purely UI (the source does not change)
  func formItemsDidBecomeVisible(_ formItems: [FormItem])
  func formItemsDidHide(_ formItems: [FormItem])
}

private class FormValidatorList: ValidatorList {
  var items: [Validator]
  
  init(items: [Validator] = []) {
    self.items = items
  }
}

public class BaseForm: Form {
  var validator: ValidatorList {
    return base
  }
  
  private var base = FormValidatorList()
  
  private var _sections: [FormSection] = [] {
    didSet {
      // Generate a validator list based on form items
      self.base = FormValidatorList(items: sections.flatMap { $0.items }.map { $0.validator })
    }
  }
  
  var sections: [FormSection] {
    get {
      return _sections.filter { !$0.isHidden }
    }
    
    set {
      _sections = newValue
    }
  }
  
  var delegate: FormDelegate?
  
  var focusMode: FocusMode = .mandatory
  
  internal func focusOnNextItem() {
    let editingFormItemIndexPath = editingFormItem?.indexPath
    
    editingFormItem?.endEditingCallback?()
    
    guard let currentIndexPath = editingFormItemIndexPath, let formItem = nextFormItem(after: currentIndexPath) else {
      return
    }
    
    formItem.beginEditingCallback?()
  }
  
  internal func nextFormItem(after indexPath: IndexPath) -> FormItem? {
    switch focusMode {
    case .none:
      return nil
    case .mandatory:
      return nextFocusableFormItem(after: indexPath, predicate: { $0.validator.isMandatory })
    case .all:
      return nextFocusableFormItem(after: indexPath)
    case .error:
      return nextFocusableFormItem(after: indexPath, predicate: { !($0.validator.isValid ?? true) })
    }
  }
  
  private func nextFocusableFormItem(after indexPath: IndexPath, predicate: ((FormItem) -> Bool)? = nil) -> FormItem? {
    guard let newIndexPath = nextIndexPath(after: indexPath) else {
      return nil
    }
    
    guard let formItem = self.formItem(at: newIndexPath) else {
      return nextFocusableFormItem(after: newIndexPath, predicate: predicate)
    }
    
    guard let condition = predicate else {
      return formItem
    }
    
    if condition(formItem) {
      return formItem
    } else {
      return nextFocusableFormItem(after: newIndexPath, predicate: predicate)
    }
  }
  
  private func nextIndexPath(after indexPath: IndexPath) -> IndexPath? {
    var nextIndexPath: IndexPath?
    
    guard indexPath.section < sections.count, indexPath.row < sections[indexPath.section].items.count else {
      return nextIndexPath
    }
    
    if indexPath.item + 1 < sections[indexPath.section].items.count {
      nextIndexPath = IndexPath(item: indexPath.item + 1, section: indexPath.section)
    } else if indexPath.section + 1 < sections.count {
      nextIndexPath = IndexPath(item: 0, section: indexPath.section + 1)
    }
    
    return nextIndexPath
  }
}

extension BaseForm {
  
  /// Focus mode of the form when after the validation of an item
  ///
  /// - none: no focus
  /// - mandatory: on next mandatory if exists
  /// - all: on next item
  /// - error: on first error
  public enum FocusMode {
    case none, mandatory, all, error
  }
}
