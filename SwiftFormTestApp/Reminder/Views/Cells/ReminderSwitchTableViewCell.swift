//
//  ReminderSwitchTableViewCell.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit
import SwiftForm

final class ReminderSwitchTableViewCell: UITableViewCell, SwitchFormItemContainer {
  @IBOutlet weak var ibTitleLabel: UILabel!
  @IBOutlet weak var ibValueSwitch: UISwitch!
  
  var formItem: FormItem?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    ibValueSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
  }
  
  @objc func switchValueChanged(_ sender: UISwitch) {
    switchFormItem?.switchDidChangeValue(sender)
  }
}

extension ReminderSwitchTableViewCell {
  var input: UISwitch {
    return ibValueSwitch
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
