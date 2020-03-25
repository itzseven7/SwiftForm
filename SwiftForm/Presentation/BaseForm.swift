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

open class BaseForm: Form, FormItemObserver {
  public var validator: ValidatorList {
    return base
  }
  
  private var base = FormValidatorList()
  
  private var _sections: [FormSection] = [] {
    didSet {
      // Generate a validator list based on form items
      self.base = FormValidatorList(items: sections.flatMap { $0.items }.map { $0.validator })
      
      // Observes all form items + add a focus on next item callback
      sections.flatMap { $0.items }.forEach {
        $0.addObserver(self)
        $0.focusOnNextItemCallback = { [weak self] current in
          self?.focusOnNextItem(after: current)
        }
      }
      
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
  
  open var priority: Int {
    return 999
  }
  
  public var formDelegate: FormDelegate?
  
  public var focusableItems: FocusableItem = [.mandatory]
  
  public init() {}
  
  internal func focusOnNextItem(after formItem: FormItem) {
    formItem.endEditing()
    formItem.isEditing = false
    
    guard let nextFormItem = self.nextFormItem(after: formItem.indexPath, typeMask: focusableItems) else {
      return
    }
    
    nextFormItem.beginEditing()
    nextFormItem.isEditing = true
  }
  
  open func onValidationEvent(formItem: FormItem) {
    formDelegate?.formItemsDidUpdate([formItem])
  }
  
  open func onActivationEvent(formItem: FormItem) {}
  
  open func onEditingEvent(formItem: FormItem) {}
  
  open func onRefreshEvent(formItem: FormItem) {}
  
  open func onVisibilityEvent(formItem: FormItem) {
    if formItem.isHidden {
      formDelegate?.formItemsDidHide([formItem])
    } else {
      formDelegate?.formItemsDidBecomeVisible([formItem])
    }
  }
}
