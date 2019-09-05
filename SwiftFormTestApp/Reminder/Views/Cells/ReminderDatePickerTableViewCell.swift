//
//  ReminderDatePickerTableViewCell.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit
import SwiftForm

final class ReminderDatePickerTableViewCell: UITableViewCell, DatePickerFormItemContainer {
  @IBOutlet weak var ibValueLabel: UILabel!
  @IBOutlet weak var ibSeparatorView: UIView!
  @IBOutlet weak var ibDatePicker: UIDatePicker!
  
  private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.current
    dateFormatter.dateFormat = "EEEE, MMM, d, y, hh:mm a"
    return dateFormatter
  }()
  
  var formItem: FormItem?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    ibValueLabel.textColor = UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1)
    
    ibDatePicker.addTarget(self, action: #selector(datePickerDidChangeValue(_:)), for: .valueChanged)
    datePickerDidChangeValue(ibDatePicker)
  }
  
  @objc func datePickerDidChangeValue(_ sender: UIDatePicker) {
    datePickerFormItem?.datePickerValueChanged(sender)
    ibValueLabel.text = dateFormatter.string(from: sender.date)
  }
}

extension ReminderDatePickerTableViewCell {
  var input: UIDatePicker {
    return ibDatePicker
  }
  
  var titleLabel: UILabel? {
    return nil
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


