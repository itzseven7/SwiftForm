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
