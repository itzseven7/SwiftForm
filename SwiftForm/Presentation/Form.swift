//
//  Form.swift
//  SwiftForm
//
//  Created by Romain on 16/08/2019.
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation

public protocol Form {
  var validator: ValidatorList { get }
  
  var sections: [FormSection] { get }
  
  var formDelegate: FormDelegate? { get set }
  
  var isEnabled: Bool { get set } // allows to disable interaction (for example: during an API call)
  
  var allItems: [FormItem] { get }
  
  func beginEditing()
  
  func endEditing(_ forceValidation: Bool)
}

extension Form {
  public var allItems: [FormItem] {
    return sections.flatMap { $0.items }
  }
  
  public var editingFormItem: FormItem? {
    return sections.flatMap { $0.items }.filter { $0.isEditing }.first
  }
  
  public func formItem(at indexPath: IndexPath) -> FormItem? {
    guard indexPath.section < sections.count, indexPath.item < sections[indexPath.section].items.count else {
      return nil
    }
    
    return sections[indexPath.section].items[indexPath.item]
  }
  
  public func beginEditing() {
    sections.first?.items.first?.beginEditing()
  }
  
  public func endEditing(_ forceValidation: Bool) {
    if forceValidation {
      editingFormItem?.validate()
    } else {
      editingFormItem?.endEditing()
    }
  }
}

public protocol FormDelegate: class {
  
  func formSectionsDidBecomeVisible(_ formSections: [FormSection])
  func formSectionsDidHide(_ formSections: [FormSection])
  
  func formItemsDidUpdate(_ formItems: [FormItem]) // maybe another method to tell the form that the update is purely UI (the source does not change)
  func formItemsDidBecomeVisible(_ formItems: [FormItem])
  func formItemsDidHide(_ formItems: [FormItem])
}
