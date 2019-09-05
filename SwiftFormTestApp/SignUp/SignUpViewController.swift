//
//  SignUpViewController.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit
import SwiftForm

protocol SignUpViewModel {
  var firstName: String? { get }
  var lastName: String? { get }
  var dateOfBirth: Date? { get }
  var placeOfBirth: String? { get }
  var emailAddress: String? { get }
  var password: String? { get }
}

final class SignUpViewController: FormTableViewController  {
  
  var signUpViewModel: SignUpViewModel? {
    return form as? SignUpViewModel
  }
  
  override func viewDidLoad() {
    form = SignUpForm()
    
    super.viewDidLoad()
    
    tableView.separatorInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
    
    tableView.reloadData()
    
    title = "Sign up"
    tableView.keyboardDismissMode = .onDrag
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    //form?.beginEditing()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    tableView.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    tableView.layoutTableHeaderView()
    tableView.layoutTableFooterView()
  }
}
