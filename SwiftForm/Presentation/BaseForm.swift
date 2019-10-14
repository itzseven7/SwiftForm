//
//  BaseForm.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation

private class FormValidatorList: ValidatorList {
  var items: [Validator]
  
  init(items: [Validator] = []) {
    self.items = items
  }
}

open class BaseForm: Form {
  public var validator: ValidatorList {
    return base
  }
  
  private var base = FormValidatorList()
  
  private var _sections: [FormSection] = [] {
    didSet {
      // Generate a validator list based on form items
      self.base = FormValidatorList(items: sections.flatMap { $0.items }.map { $0.validator })
      
      // Observes all form items
      sections.flatMap { $0.items }.forEach { $0.addObserver(self) }
      
      // Generates index paths
      for i in 0..<sections.count {
        let section = sections[i]
        
        for j in 0..<section.items.count {
          section.items[j].indexPath = IndexPath(item: j, section: i)
        }
      }
    }
  }
  
  public var sections: [FormSection] {
    get {
      return _sections.filter { !$0.isHidden }
    }
    
    set {
      _sections = newValue
    }
  }
  
  public var isEnabled: Bool = true {
    didSet {
      sections.flatMap { $0.items }.forEach { $0.isEnabled = isEnabled }
    }
  }
  
  public var allItems: [FormItem] {
    return sections.flatMap { $0.items }.filter{ !$0.isHidden }
  }
  
  public var delegate: FormDelegate?
  
  public var focusableItems: FocusableItem = [.mandatory]
  
  public init() {}
  
  internal func focusOnNextItem() {
    guard let editingFormItem = editingFormItem else {
      return
    }
    
    editingFormItem.endEditing()
    editingFormItem.isEditing = false
    
    guard let nextFormItem = self.nextFormItem(after: editingFormItem.indexPath, typeMask: focusableItems) else {
      return
    }
    
    nextFormItem.beginEditing()
    nextFormItem.isEditing = true
  }
}

extension BaseForm: FormItemObserver {
  public var priority: Int {
    return 999
  }
  
  public func onValidationEvent(formItem: FormItem) {
    delegate?.formItemsDidUpdate([formItem])
    focusOnNextItem()
  }
  
  public func onActivationEvent(formItem: FormItem) {}
  
  public func onEditingEvent(formItem: FormItem) {}
  
  public func onRefreshEvent(formItem: FormItem) {}
  
  public func onVisibilityEvent(formItem: FormItem) {
    if formItem.isHidden {
      delegate?.formItemsDidHide([formItem])
    } else {
      delegate?.formItemsDidBecomeVisible([formItem])
    }
  }
}
