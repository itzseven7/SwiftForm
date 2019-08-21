//
//  FormItem.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

public protocol FormItem: class {
  
  var validator: Validator { get }
  
  var indexPath: IndexPath { get set } // there should not be a public setter
  
  var title: String? { get }
  
  var description: String? { get }
  
  var isEnabled: Bool { get set }
  
  var isHidden: Bool { get set }
  
  var isEditing: Bool { get set }
  
  var beginEditingCallback: (() -> Void)? { get set }
  
  var endEditingCallback: (() -> Void)? { get set }
  
  /// You should use this method to begin editing instead of the callback
  func beginEditing()
  
  /// You should use this method to begin editing instead of the callback
  func endEditing()
  
  func validate()
  
  func addObserver(_ observer: FormItemObserver)
  
  // Tmp methods (may be removed later)
  
  func didBindWithContainer()
}

extension FormItem {
  public var error: String? {
    return validator.error
  }
  
  public func beginEditing() {
    beginEditingCallback?()
  }
  
  public func endEditing() {
    endEditingCallback?()
  }
}

extension FormItem where Self: Equatable {
  public static func ==(lhs: Self, rhs: Self) -> Bool {
    return lhs.indexPath == rhs.indexPath
  }
}

public protocol FormItemObserver {
  // 1 => first notified, 1000 => last notified
  var priority: Int { get }
  
  func onContainerBinding(formItem: FormItem) // only called once, after the form item is assigned to the container
  func onValidationEvent(formItem: FormItem) // validation of the validator
  func onActivationEvent(formItem: FormItem) // isEnabled change
  func onEditingEvent(formItem: FormItem) // isEditing change
  func onVisibilityEvent(formItem: FormItem) // isHidden change
}

open class FormItemInput<ValueType: Comparable, InputValueType>: FormItem, Equatable {
  public var validator: Validator {
    return base
  }
  
  public final var base: ValueValidator<ValueType>!
  
  var value: ValueType? {
    return base.value
  }
  
  /// The input value reflects the current value of the input
  public var inputValue: InputValueType?
  
  public var indexPath: IndexPath = IndexPath(item: 0, section: 0)
  
  public var title: String?
  
  public var description: String?
  
  public var isEnabled: Bool = true
  
  public var isHidden: Bool = false
  
  public var isEditing: Bool = false
  
  public var beginEditingCallback: (() -> Void)?
  
  public var endEditingCallback: (() -> Void)?
  
  internal var observers: [FormItemObserver] = []
  
  public init(value: ValueType? = nil) {
    base = self.validator(value)
    base.subscribe { [weak self] _ in
      guard let sSelf = self else { return }
      sSelf.notify { $0.onValidationEvent(formItem: sSelf)}
    }
  }
  
  // You should override this method to provide your own validator
  open func validator(_ value: ValueType?) -> ValueValidator<ValueType> {
    preconditionFailure("You must provide a validator")
  }
  
  open func validate() {
    base.validate(self.value(from: inputValue))
  }
  
  public func subscribe<T: Comparable, U>(to formItem: FormItemInput<T, U>,_ handler: @escaping ((T?) -> Void)) {
    formItem.base.subscribe { (value) in handler(value) }
  }
  
  public func addObserver(_ observer: FormItemObserver) {
    observers.append(observer)
  }
  
  public func notify(_ action: ((FormItemObserver) -> Void)) {
    observers.sorted(by: { $0.priority < $1.priority }).forEach { action($0) }
  }
  
  public func didBindWithContainer() {
    notify { [weak self] observer in
      guard let sSelf = self else { return }
      observer.onContainerBinding(formItem: sSelf)
    }
  }
  
  // Conversion methods
  
  open func value(from inputValue: InputValueType?) -> ValueType? {
    preconditionFailure("You must override this method in subclass")
  }
  
  open func inputValue(from value: ValueType?) -> InputValueType? {
    preconditionFailure("You must override this method in subclass")
  }
}

open class TextFormItemInput<ValueType: Comparable>: FormItemInput<ValueType, String> {
  open var text: String? {
    let inputValue = self.inputValue(from: base.value)
    return formatted(inputValue) ?? inputValue
  }
  
  open var maximumCharacters: Int = -1
  
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
