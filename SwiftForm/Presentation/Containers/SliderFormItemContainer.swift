//
//  SliderFormItemContainer.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

public protocol SliderFormItemContainer: FormItemInputContainer {
  var input: UISlider { get }
}

extension SliderFormItemContainer {
  public var sliderFormItem: SliderFormItem? {
    return formItem as? SliderFormItem
  }
}

extension SliderFormItemContainer {
  public func setUp() {
    formItem?.addObserver(self)
    
    bind()
    finishSetUp()
  }
  
  public func bind() {
    guard let sliderFormItem = sliderFormItem else { return }
    
    titleLabel?.text = sliderFormItem.title
    descriptionLabel?.text = sliderFormItem.description
    errorLabel?.text = sliderFormItem.error
    
    input.isEnabled = sliderFormItem.isEnabled
    input.value = sliderFormItem.value
    input.minimumValue = sliderFormItem.minimumValue
    input.maximumValue = sliderFormItem.maximumValue
    input.minimumValueImage = sliderFormItem.minimumValueImage
    input.maximumValueImage = sliderFormItem.maximumValueImage
    input.isContinuous = sliderFormItem.isContinuous
  }
}
