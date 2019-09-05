//
//  SignUpForm.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit
import SwiftForm

enum SignUpCellType: TableViewFormItemCellType {
  
  case textField
  case datePickerInput
  case pickerInput
  
  func dequeueCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
    switch self {
    case .textField:
      return tableView.dequeueReusableCell(withIdentifier: String(describing: TextFieldTableViewCell.self), for: indexPath)
    case .datePickerInput:
      return tableView.dequeueReusableCell(withIdentifier: String(describing: DatePickerFieldTableViewCell.self), for: indexPath)
    case .pickerInput:
      return tableView.dequeueReusableCell(withIdentifier: String(describing: PickerViewFieldTableViewCell.self), for: indexPath)
    }
  }
  
  static func registerCells(for tableView: UITableView) {
    tableView.register(UINib(nibName: String(describing: TextFieldTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TextFieldTableViewCell.self))
    tableView.register(UINib(nibName: String(describing: DatePickerFieldTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: DatePickerFieldTableViewCell.self))
    tableView.register(UINib(nibName: String(describing: PickerViewFieldTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: PickerViewFieldTableViewCell.self))
  }
}

final class SignUpForm: BaseTableViewForm {
  
  override init() {
    super.init()
    
    focusMode = .none
    
    let headerView: HeaderView = UIView.fromNib()
    headerView.ibTitleLabel.text = "SignUp Form"
    headerView.ibDescriptionLabel.text = "This form demonstrates the library power"
    tableHeaderView = headerView
    
    let footerView: SignUpFooterView = UIView.fromNib()
    footerView.ibButton.setTitle("Sign up", for: .normal)
    tableFooterView = footerView
    
    let generalSection = BaseTableViewFormSection()
    
    let generalSectionHeaderView: LeftTitleHeaderView = UIView.fromNib()
    generalSectionHeaderView.ibHeaderLabel.text = "General".uppercased()
    
    generalSection.headerView = generalSectionHeaderView
    
    generalSection.items = [FirstNameFormItem(), LastNameFormItem(), DateOfBirthFormItem(), PlaceOfBirthFormItem()]
    
    let loginSection = BaseTableViewFormSection()
    
    let loginSectionHeaderView: LeftTitleHeaderView = UIView.fromNib()
    loginSectionHeaderView.ibHeaderLabel.text = "Credentials".uppercased()
    
    loginSection.headerView = loginSectionHeaderView
    
    loginSection.items = [EmailAddressFormItem(), PasswordFormItem()]
    
    sections = [generalSection, loginSection]
  }
  
  override func registerCells(for tableView: UITableView) {
    SignUpCellType.registerCells(for: tableView)
  }
}
