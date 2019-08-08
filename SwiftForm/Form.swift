//
//  Form.swift
//  CPA-ios
//
//  Copyright © 2019 itzseven7. All rights reserved.
//

import Foundation

/// The Form protocol defines the basic attributes/methods for a logic form
public protocol Form {
  
  /// The sections of the form
  var items: [FormItem] { get set }
  
  var isValid: Bool? { get }
  var hasChanges: Bool { get }
  
  func checkValidity()
}

extension Form {
  
  /// Returns true if all the form items are valid, otherwise false
  var isValid: Bool? {
    return items.filter {
      if $0.isMandatory {
        return !($0.isValid ?? false)
      } else {
        if let isValid = $0.isValid {
          return !isValid
        }
      }
      return false
    }.isEmpty
  }
  
  /// Returns true if at least one form item has changes, otherwise false
  var hasChanges: Bool {
    return !items.filter { $0.hasChanges }.isEmpty
  }
  
  /// Checks the validity of the form items
  func checkValidity() {
    items.forEach { $0.checkValidity() }
  }
}
