//
//  Containable.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

protocol Containable {
  associatedtype ContainerType
  
  var container: ContainerType { get }
}

// TODO: New form item containers should only update their components with the FormItemObserver event methods
// Normally when the form item is assigned to the container, the communication should stay between FormItem and its container and not be fowarded by the Form

protocol FormItemContainer: Containable {
  associatedtype FormItemType: FormItem
  
  var formItem: FormItemType { get set }
  
  var titleLabel: UILabel? { get }
  
  var descriptionLabel: UILabel? { get }
  
  var errorLabel: UILabel? { get }
}
