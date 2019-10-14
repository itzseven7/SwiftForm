//
//  PickerViewFormItemContainer.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

public protocol PickerViewFormItemContainer: FormItemInputContainer {
  var input: UIPickerView { get }
}

extension PickerViewFormItemContainer {
  public var pickerViewFormItem: PickerViewFormItem? {
    return formItem as? PickerViewFormItem
  }
}

extension PickerViewFormItemContainer {
  public func setUp() {
    formItem?.addObserver(self)
    
    bind()
    finishSetUp()
  }
  
  public func bind() {
    guard let pickerViewFormItem = pickerViewFormItem else { return }
    
    titleLabel?.text = pickerViewFormItem.title
    descriptionLabel?.text = pickerViewFormItem.description
    errorLabel?.text = pickerViewFormItem.error
  }
  
  public func onRefreshEvent(formItem: FormItem) {
    bind()
  }
}
