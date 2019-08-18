//
//  FormSectionViewModel.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation

protocol FormSectionViewModel {
  var items: [FormItemViewModel] { get }
  
  var isHidden: Bool { get set }
}

class BaseFormSectionViewModel: FormSectionViewModel {
  private var _items: [FormItemViewModel] = []
  
  var items: [FormItemViewModel] {
    get {
      return _items.filter { !$0.isHidden }
    }
    
    set {
      _items = newValue
    }
  }
  
  var isHidden: Bool = false
}
