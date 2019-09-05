//
//  ReminderFormViewController.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit
import SwiftForm

final class ReminderFormViewController: FormTableViewController {
  override func viewDidLoad() {
    form = ReminderForm()
    
    super.viewDidLoad()
    
    title = "Create reminder"
    tableView.separatorInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    tableView.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
  }
}
