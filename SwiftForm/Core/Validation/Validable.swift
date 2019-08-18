//
//  Validable.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation

/// This protocol defines the base behavior of an object which validates something
public protocol Validable {
  
  /// A boolean value which indicates whether the validator is valid or not
  ///
  /// A nil value means that the validator has not already checked the value 
  var isValid: Bool? { get }
  
  /// A boolean value which indicates whether the validator has changes
  var hasChanges: Bool { get }
  
  /// Checks the validity of the current value
  func checkValidity()
}
