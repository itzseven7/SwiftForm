//
//  FormItemInputContainer.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

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
