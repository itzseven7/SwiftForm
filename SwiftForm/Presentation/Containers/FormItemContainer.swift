//
//  FormItemContainer.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import Foundation

public protocol FormItemContainer: class, FormItemObserver {
  
  var formItem: FormItem? { get set }
  
  func setUp() // called once, after the form item is assigned
  func bind() // called several times to bind form item attributes to container
  func finishSetUp() // called once, after the container is setup
}

extension FormItemContainer {
  public var priority: Int {
    return 1
  }
  
  public func onValidationEvent(formItem: FormItem) {}
  
  public func onActivationEvent(formItem: FormItem) {}
  
  public func onEditingEvent(formItem: FormItem) {}
  
  public func onRefreshEvent(formItem: FormItem) {
    bind()
  }
  
  public func onVisibilityEvent(formItem: FormItem) {}
}
