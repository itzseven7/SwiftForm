//
//  SignUpViewController.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit
import SwiftForm

final class SignUpViewController: FormTableViewController {
  
  var signUpForm: SignUpForm? {
    return form as? SignUpForm
  }
  
  override func viewDidLoad() {
    form = SignUpForm()
    
    super.viewDidLoad()
    
    title = "Sign up"
    
    tableView.reloadData()
    
    tableView.separatorInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
    tableView.keyboardDismissMode = .onDrag
    
    signUpForm?.actionButtonCallback = { [weak self] in
      self?.doneAction()
    }
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    tableView.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    tableView.layoutTableHeaderView()
    tableView.layoutTableFooterView()
  }
  
  func doneAction() {
    // force validation here
    guard let values = signUpForm?.getValues() else { return }
    
    var message = ""
    
    message += "First name: \(values.firstName)\n"
    message += "Last name: \(values.lastName)\n"
    message += "Date of birth: \(values.dateOfBirth)\n"
    message += "Place of birth: \(values.placeOfBirth)\n"
    message += "Email address: \(values.emailAddress)\n"
    message += "Password: \(values.password)\n"
    
    let alertViewController = UIAlertController(title: "Values", message: message, preferredStyle: .alert)
    
    alertViewController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
    
    present(alertViewController, animated: true, completion: nil)
  }
}
