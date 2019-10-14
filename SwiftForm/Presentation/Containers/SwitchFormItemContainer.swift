//
//  SwitchFormItemContainer.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

public protocol SwitchFormItemContainer: FormItemInputContainer {
  var input: UISwitch { get }
}

extension SwitchFormItemContainer {
  public var switchFormItem: SwitchFormItem? {
    return formItem as? SwitchFormItem
  }
}

extension SwitchFormItemContainer {
  public func setUp() {
    formItem?.addObserver(self)
    
    bind()
    finishSetUp()
  }
  
  public func bind() {
    guard let switchFormItem = switchFormItem else { return }
    
    titleLabel?.text = switchFormItem.title
    descriptionLabel?.text = switchFormItem.description
    errorLabel?.text = switchFormItem.error
    
    input.isEnabled = switchFormItem.isEnabled
    input.isOn = switchFormItem.isOn
  }
}
