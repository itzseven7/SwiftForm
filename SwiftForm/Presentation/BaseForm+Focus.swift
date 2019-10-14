//
//  Form+Focus.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation

extension BaseForm {
  internal func nextFormItem(after indexPath: IndexPath, typeMask: FocusableItem) -> FormItem? {
    guard !typeMask.isEmpty else {
      return nil
    }
    
    if typeMask.contains(.invalid) {
      if let nextItem = nextFocusableFormItem(after: indexPath, predicate: { !($0.validator.isValid ?? true) }) {
        return nextItem
      } else {
        return nextFormItem(after: indexPath, typeMask: typeMask.subtracting(.invalid))
      }
    } else if typeMask.contains(.mandatory) {
      if let nextItem = nextFocusableFormItem(after: indexPath, predicate: { $0.validator.isMandatory && $0.validator.isValid == nil }) {
        return nextItem
      } else {
        return nextFormItem(after: indexPath, typeMask: typeMask.subtracting(.mandatory))
      }
    } else if typeMask.contains(.optional) {
      if let nextItem = nextFocusableFormItem(after: indexPath, predicate: { !$0.validator.isMandatory && $0.validator.isValid == nil }) {
        return nextItem
      } else {
        return nextFormItem(after: indexPath, typeMask: typeMask.subtracting(.optional))
      }
    }
    
    return nil
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
    
    guard indexPath.section < sections.count, indexPath.item < sections[indexPath.section].items.count else {
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
  
  public struct FocusableItem: OptionSet {
    public let rawValue: Int
    
    public static let optional = FocusableItem(rawValue: 1 << 0) // 1
    public static let mandatory = FocusableItem(rawValue: 1 << 1) // 2
    public static let invalid = FocusableItem(rawValue: 1 << 2) // 4
    ///public static let previous = FocusableItem(rawValue: 1 << 3) // 8 (if form items that follow editing form item are valid and there is a non valid form item before, the form item will focus it
    
    /// Will check for mandatory first, then optional
    public static let any: FocusableItem = [.optional, .mandatory] // 3 (should be renamed)
    
    /// Will check for invalid first, then mandatory, then optional
    public static let all: FocusableItem = [.optional, .mandatory, .invalid] // 7
    
    public init(rawValue: Int) {
      self.rawValue = rawValue
    }
    
    internal func containsOnly(option: FocusableItem) -> Bool {
      return self.subtracting(option).isEmpty
    }
  }
}


