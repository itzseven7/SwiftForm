//
//  ReminderSegmentedControlTableViewCell.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit
import SwiftForm

final class ReminderSegmentedControlTableViewCell: UITableViewCell, SegmentedControlFormItemContainer {
  @IBOutlet weak var ibTitleLabel: UILabel!
  @IBOutlet weak var ibSegmentedControl: UISegmentedControl!
  
  var formItem: FormItem?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    ibSegmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
  }
  
  @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
    segmentedControlFormItem?.segmentedControlDidChangeSegment(sender)
  }
}

extension ReminderSegmentedControlTableViewCell {
  var input: UISegmentedControl {
    return ibSegmentedControl
  }
  
  var titleLabel: UILabel? {
    return ibTitleLabel
  }
  
  var descriptionLabel: UILabel? {
    return nil
  }
  
  var errorLabel: UILabel? {
    return nil
  }
  
  func finishSetUp() {
    
  }
}
