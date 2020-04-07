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
  
  /// A boolean value that indicates whether the item is in editing mode/focused
  ///
  /// This property is relevant when the item handles an input that waits for user action like text fields. For example, changing this property for a segmented control or a switch is not necessary
  /// Note that this property is used by the parent form to determine the current editing form item and find the next to focus
  var isEditing: Bool { get set }
  
  var beginEditingCallback: (() -> Void)? { get set }
  
  var endEditingCallback: (() -> Void)? { get set }
  
  var focusOnNextItemCallback: ((FormItem) -> Void)? { get set }
  
  /// You should use this method to begin editing instead of the callback
  func beginEditing()
  
  /// You should use this method to end editing instead of the callback
  func endEditing()
  
  func validate()
  
  func addObserver(_ observer: FormItemObserver)
}

extension FormItem {
  public var error: String? {
    return validator.error
  }
}

extension FormItem where Self: Equatable {
  public static func ==(lhs: Self, rhs: Self) -> Bool {
    return lhs.indexPath == rhs.indexPath
  }
}

public enum FormItemState {
  /// The item is disabled, interaction is impossible
  case disabled
  
  /// The item is valid or has no value
  case normal
  
  /// the item is focused
  case editing
  
  /// the item has an error
  case error
}

extension FormItem {
  public var state: FormItemState {
    guard isEnabled else { return .disabled }
    
    if !(validator.isValid == nil || validator.isValid == true) {
      return .error
    } else {
      if isEditing {
        return .editing
      } else {
        return .normal
      }
    }
  }
}

public protocol FormItemObserver {
  /**
   The observer's priority.
   
   This property tells the form item to choose a proper order to notify its observers. You can decide in which order a type of observer will be notified compared to other types.
   
   The higher the value is, the greater prioritary the observer is
   
   By default, containers are notified first (priority equal to 1) followed by the form (priority of 2)
   */
  var priority: Int { get }
  
  func onValidationEvent(formItem: FormItem) // validation of the validator
  func onActivationEvent(formItem: FormItem) // isEnabled change
  func onEditingEvent(formItem: FormItem) // isEditing change
  func onVisibilityEvent(formItem: FormItem) // isHidden change
  
  /// Tells the observer that it needs to update itself because of an unknown change in the form item
  ///
  /// - Parameter formItem: the form item
  func onRefreshEvent(formItem: FormItem) // called when a change needs to be reported on observers
}
