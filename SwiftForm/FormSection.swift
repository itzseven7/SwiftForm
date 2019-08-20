//
//  FormSection.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation

public protocol FormSection {
  var items: [FormItem] { get }
  
  var isHidden: Bool { get set }
}

open class BaseFormSection: FormSection {
  private var _items: [FormItem] = []
  
  public var items: [FormItem] {
    get {
      return _items.filter { !$0.isHidden }
    }
    
    set {
      _items = newValue
    }
  }
  
  public var isHidden: Bool = false
  
  public init() {
    
  }
}
