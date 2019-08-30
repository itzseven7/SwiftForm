//
//  StepperFormItemContainer.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

public protocol StepperFormItemContainer: FormItemInputContainer {
  var input: UIStepper { get }
}

extension StepperFormItemContainer {
  public var stepperFormItem: StepperFormItem? {
    return formItem as? StepperFormItem
  }
}

extension StepperFormItemContainer {
  public func setUp() {
    formItem?.addObserver(self)
    
    bind()
    finishSetUp()
  }
  
  public func bind() {
    guard let stepperFormItem = stepperFormItem else { return }
    
    titleLabel?.text = stepperFormItem.title
    descriptionLabel?.text = stepperFormItem.description
    errorLabel?.text = stepperFormItem.error
    
    input.isEnabled = stepperFormItem.isEnabled
    input.value = stepperFormItem.value
    input.minimumValue = stepperFormItem.minimumValue
    input.maximumValue = stepperFormItem.maximumValue
    input.stepValue = stepperFormItem.stepValue
    input.isContinuous = stepperFormItem.isContinuous
    input.autorepeat = stepperFormItem.autorepeat
    input.wraps = stepperFormItem.wraps
  }
}
