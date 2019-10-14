//
//  ReminderFormViewController.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit
import SwiftForm

final class ReminderFormViewController: FormTableViewController {
  
  var reminderForm: ReminderForm? {
    return form as? ReminderForm
  }
  
  override func viewDidLoad() {
    form = ReminderForm()
    
    super.viewDidLoad()
    
    title = "Create reminder"
    tableView.separatorInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
  }
  
  @objc func doneAction() {
    // force validation here
    guard let values = reminderForm?.getValues() else { return }
    
    var message = ""
    
    message += "Name: \(values.name)\n"
    message += "Date: \(values.date)\n"
    message += "OnDay: \(values.onDay)\n"
    message += "OnLocation: \(values.onLocation)\n"
    message += "Priority: \(values.priority)\n"
    message += "Notes: \(values.notes)\n"
    
    let alertViewController = UIAlertController(title: "Values", message: message, preferredStyle: .alert)
    
    alertViewController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
    
    present(alertViewController, animated: true, completion: nil)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    tableView.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
  }
}
