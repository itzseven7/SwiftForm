//
//  TextFormItem.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation

public protocol TextFormItemObserver: FormItemObserver {
  func onTextChangedEvent(formItem: TextFormItem)
}

public protocol TextFormItem: FormItem {
  var text: String? { get }
  
  func formatted(_ value: String?) -> String?
  func unformatted(_ value: String?) -> String?
}

open class TextFormItemInput<ValueType: Equatable>: InputFormItem<ValueType, String>, TextFormItem {
  open var text: String? {
    let inputValue = self.inputValue(from: valueValidator.value)
    return formatted(inputValue) ?? inputValue
  }
  
  public var maximumCharacters: Int = -1
  
  open override func validate() {
    let text = (inputValue == nil) || (inputValue?.isEmpty ?? true) ? nil : inputValue
    valueValidator.validate(self.value(from: text))
  }
  
  // Conversion methods
  
  open func formatted(_ value: String?) -> String? {
    // Needs implementation in subclass
    return nil
  }
  
  open func unformatted(_ value: String?) -> String? {
    // Needs implementation in subclass
    return nil
  }
}

extension TextFormItemInput {
  public func notifyTextChange() {
    notify { [weak self] observer in
      guard let sSelf = self else { return }
      (observer as? TextFormItemObserver)?.onTextChangedEvent(formItem: sSelf)
    }
  }
}
