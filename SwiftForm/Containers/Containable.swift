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

extension FormItemInputContainer {
  var titleLabel: UILabel? { return nil }
  
  var descriptionLabel: UILabel? { return nil }
  
  var errorLabel: UILabel? { return nil }
}

public protocol TextViewFormItemContainer: FormItemInputContainer {
  var input: UITextView { get }
}
