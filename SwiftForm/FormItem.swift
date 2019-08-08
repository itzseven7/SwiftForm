//
//  FormItem.swift
//  CPA-ios
//
//  Copyright © 2019 itzseven7. All rights reserved.
//

import UIKit

public protocol FormItemErrorProvider {
  
  var noValueError: String? { get }
}

public protocol FormItem: class {
  
  /// A specific error which explains why the value is invalid
  var error: String? { get }
  
  /// A boolean value which indicates whether the form item is valid or not
  ///
  /// A nil value means that the form item has not been validated yet
  var isValid: Bool? { get }
  
  /// A boolean value which indicates whether the form item is mandatory or not
  ///
  /// A non mandatory form item is valid if it has a nil value.
  var isMandatory: Bool { get set }
  
  /// A boolean value which indicates whether the form item has changes or not
  var hasChanges: Bool { get }
  
  /// Checks the validity of the current value
  func checkValidity()
}
