//
//  ValidatorList.swift
//  CPA-ios
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation

public protocol ValidatorList: Validable {
  
  var items: [Validator] { get }
}

extension ValidatorList {
  
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
  
  var hasChanges: Bool {
    return !items.filter { $0.hasChanges }.isEmpty
  }
  
  func checkValidity() {
    items.forEach { $0.checkValidity() }
  }
}
