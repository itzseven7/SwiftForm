//
//  SegmentedControlFormItemContainer.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

public protocol SegmentedControlFormItemContainer: FormItemInputContainer {
  var input: UISegmentedControl { get }
}

extension SegmentedControlFormItemContainer {
  public var segmentedControlFormItem: SegmentedControlFormItem? {
    return formItem as? SegmentedControlFormItem
  }
}

extension SegmentedControlFormItemContainer {
  public func setUp() {
    formItem?.addObserver(self)
    
    bind()
    finishSetUp()
  }
  
  public func bind() {
    guard let segmentedControlFormItem = segmentedControlFormItem else { return }
    
    titleLabel?.text = segmentedControlFormItem.title
    descriptionLabel?.text = segmentedControlFormItem.description
    errorLabel?.text = segmentedControlFormItem.error
    
    input.isEnabled = segmentedControlFormItem.isEnabled
    
    for i in 0..<segmentedControlFormItem.titles.count {
      input.setTitle(segmentedControlFormItem.titles[i], forSegmentAt: i)
      input.setEnabled(segmentedControlFormItem.segmentIsEnabled(at: i), forSegmentAt: i)
    }
    
    input.selectedSegmentIndex = segmentedControlFormItem.selectedSegmentIndex
  }
}
