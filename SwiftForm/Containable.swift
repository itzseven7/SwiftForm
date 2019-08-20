//
//  Containable.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

protocol Containable {
  associatedtype ContainerType
  
  func onContainerSetUp(container: ContainerType)
}

protocol Container {
  associatedtype ContainableType
  
  
}

protocol FormContainer: Container {
  
}

// TODO: New form item containers should only update their components with the FormItemObserver event methods
// Normally when the form item is assigned to the container, the communication should stay between FormItem and its container and not be fowarded by the Form
// Remember that container must notify containable

public protocol FormItemContainer: class, FormItemObserver {
  
  var formItem: FormItem? { get set }
  
  func configure()
}

public protocol FormItemInputContainer: FormItemContainer {
  associatedtype InputType: UIView
  
  var input: InputType { get }
  
  var titleLabel: UILabel? { get }
  
  var descriptionLabel: UILabel? { get }
  
  var errorLabel: UILabel? { get }
}

extension FormItemInputContainer {
  var titleLabel: UILabel? { return nil }
  
  var descriptionLabel: UILabel? { return nil }
  
  var errorLabel: UILabel? { return nil }
}

public protocol TextFieldFormItemContainer: FormItemInputContainer {
  var input: UITextField { get }
}

extension TextFieldFormItemContainer {
  public var textFieldFormItem: TextFieldFormItem? {
    return formItem as? TextFieldFormItem
  }
}

extension TextFieldFormItemContainer where Self: NSObject & UITextFieldDelegate {
  public func configure() {
    input.delegate = self
    
    formItem?.beginEditingCallback = { [weak self] in
      self?.input.becomeFirstResponder()
    }
    
    formItem?.endEditingCallback = { [weak self] in
      self?.input.resignFirstResponder()
    }
    
    formItem?.addObserver(self)
  }
}

public protocol TextViewFormItemContainer: FormItemInputContainer {
  var input: UITextView { get }
}

public protocol PickerViewFormItemContainer: FormItemInputContainer {
  var input: UIPickerView { get }
}

public protocol DatePickerFormItemContainer: FormItemInputContainer {
  var input: UIDatePicker { get }
}
