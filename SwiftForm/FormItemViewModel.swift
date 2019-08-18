//
//  FormItemViewModel.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

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
  
  /// You should use this method to begin editing instead of the callback
  func beginEditing()
  
  /// You should use this method to begin editing instead of the callback
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
  
  var base: BaseFormItem<ValueType>!
  
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
    base = self.base(value)
  }
  
  // You should override this method to provide your own checker
  public func base(_ value: ValueType?) -> BaseFormItem<ValueType> {
    return BaseFormItem(value: value)
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
