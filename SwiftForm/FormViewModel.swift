//
//  FormViewModel.swift
//  SwiftForm
//
//  Created by Romain on 16/08/2019.
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation

private class InternalForm: Form {
  var items: [FormItem]
  
  init(items: [FormItem] = []) {
    self.items = items
  }
}

public class BaseFormViewModel: FormViewModel {
  var form: Form {
    return base
  }
  
  private var base = InternalForm()
  
  var sections: [FormSectionViewModel] = [] {
    didSet {
      self.base = InternalForm(items: sections.flatMap { $0.items }.map { $0.item }) // generate a logic form
    }
  }
  
  var focusMode: FocusMode = .mandatory
  
  init() {
    base = InternalForm()
  }
  
  internal func focusOnNextItem() {
    let editingFormItemIndexPath = editingFormItem?.indexPath
    
    editingFormItem?.endEditingCallback?()
    
    guard let currentIndexPath = editingFormItemIndexPath, let formItem = nextFormItem(after: currentIndexPath) else {
      return
    }
    
    formItem.beginEditingCallback?()
  }
  
  internal func nextFormItem(after indexPath: IndexPath) -> FormItemViewModel? {
    switch focusMode {
    case .none:
      return nil
    case .mandatory:
      return nextFocusableFormItem(after: indexPath, predicate: { $0.item.isMandatory })
    case .all:
      return nextFocusableFormItem(after: indexPath)
    case .error:
      return nextFocusableFormItem(after: indexPath, predicate: { !($0.item.isValid ?? true) })
    }
  }
  
  private func nextFocusableFormItem(after indexPath: IndexPath, predicate: ((FormItemViewModel) -> Bool)? = nil) -> FormItemViewModel? {
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

extension BaseFormViewModel {
  
  
  
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

protocol FormViewModel {
  var form: Form { get }
  
  var sections: [FormSectionViewModel] { get }
}

extension FormViewModel {
  var allItems: [FormItemViewModel] {
    return sections.flatMap { $0.items }.filter { !$0.isHidden }
  }
  
  var editingFormItem: FormItemViewModel? {
    return sections.flatMap { $0.items }.filter { $0.isEditing }.first
  }
  
  func formItem(at indexPath: IndexPath) -> FormItemViewModel? {
    guard indexPath.section < sections.count, indexPath.item < sections[indexPath.section].items.count else {
      return nil
    }
    
    return sections[indexPath.section].items[indexPath.item]
  }
}

protocol FormSectionViewModel {
  var items: [FormItemViewModel] { get }
}

protocol FormItemViewModel: class {
  
  var item: FormItem { get }
  
  var indexPath: IndexPath { get }
  
  var title: String? { get }
  
  var titleAttributedString: NSAttributedString? { get }
  
  var description: String? { get }
  
  var descriptionAttributedString: NSAttributedString? { get }
  
  var errorAttributedString: NSAttributedString? { get }
  
  var isEnabled: Bool { get set }
  
  var isHidden: Bool { get set }
  
  var isEditing: Bool { get set }
  
  var beginEditingCallback: (() -> Void)? { get set }
  
  var endEditingCallback: (() -> Void)? { get set }
  
  func beginEditing()
  
  func endEditing()
}

extension FormItemViewModel {
  func beginEditing() {
    beginEditingCallback?()
  }
  
  func endEditing() {
    endEditingCallback?()
  }
}

class BaseFormItemViewModel<ValueType: Comparable, InputValueType>: FormItemViewModel {
  var item: FormItem {
    return base
  }
  
  var base: BaseFormItem<ValueType>
  
  var value: ValueType? {
    return base.value
  }
  
  var inputValue: InputValueType?
  
  var indexPath: IndexPath = IndexPath(item: 0, section: 0)
  
  var title: String?
  
  var titleAttributedString: NSAttributedString?
  
  var description: String?
  
  var descriptionAttributedString: NSAttributedString?
  
  var errorAttributedString: NSAttributedString?
  
  var isEnabled: Bool = true
  
  var isHidden: Bool = false
  
  var isEditing: Bool = false
  
  var beginEditingCallback: (() -> Void)?
  
  var endEditingCallback: (() -> Void)?
  
  init(value: ValueType? = nil) {
    base = BaseFormItem(value: value)
  }
  
  // Conversion methods
  
  func value(from inputValue: InputValueType?) -> ValueType? {
    // Needs implementation in subclass
    return nil
  }
  
  func inputValue(from value: ValueType?) -> InputValueType? {
    // Needs implementation in subclass
    return nil
  }
}

class TextFormItemViewModel<ValueType: Comparable>: BaseFormItemViewModel<ValueType, String> {
  var text: String? {
    let inputValue = self.inputValue(from: base.value)
    return formatted(inputValue) ?? inputValue
  }
  
  // Conversion methods
  
  func formatted(_ value: String?) -> String? {
    // Needs implementation in subclass
    return nil
  }
  
  func unformatted(_ value: String?) -> String? {
    // Needs implementation in subclass
    return nil
  }
}

class TextFieldFormItemViewModel<ValueType: Comparable>: TextFormItemViewModel<ValueType> {
  
}
