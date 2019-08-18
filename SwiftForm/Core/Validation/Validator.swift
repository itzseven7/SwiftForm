//
//  Validator.swift
//  CPA-ios
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

public protocol Validator: class, Validable {
  
  /// A message which explains why the value is invalid
  var error: String? { get }
  
  /// A boolean value which indicates whether the validator is mandatory or not
  var isMandatory: Bool { get set }
}
