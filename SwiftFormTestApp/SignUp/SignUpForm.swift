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
  
  var firstNameFormItem: FirstNameFormItem
  var lastNameFormItem: LastNameFormItem
  var dateOfBirthFormItem: DateOfBirthFormItem
  var placeOfBirthFormItem: PlaceOfBirthFormItem
  var emailAddressFormItem: EmailAddressFormItem
  var passwordFormItem: PasswordFormItem
  
  var actionButtonCallback: (() -> Void)?
  
  override init() {
    firstNameFormItem = FirstNameFormItem()
    lastNameFormItem = LastNameFormItem()
    dateOfBirthFormItem = DateOfBirthFormItem()
    placeOfBirthFormItem = PlaceOfBirthFormItem()
    emailAddressFormItem = EmailAddressFormItem()
    passwordFormItem = PasswordFormItem()
    
    super.init()
    
    focusableItems = []
    
    let headerView: HeaderView = UIView.fromNib()
    headerView.ibTitleLabel.text = "SignUp Form"
    headerView.ibDescriptionLabel.text = "Errors are displayed here"
    tableHeaderView = headerView
    
    let footerView: SignUpFooterView = UIView.fromNib()
    footerView.ibButton.setTitle("Sign up", for: .normal)
    footerView.ibButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    tableFooterView = footerView
    
    let generalSection = BaseTableViewFormSection()
    
    let generalSectionHeaderView: LeftTitleHeaderView = UIView.fromNib()
    generalSectionHeaderView.ibHeaderLabel.text = "General".uppercased()
    
    generalSection.headerView = generalSectionHeaderView
    
    generalSection.items = [firstNameFormItem, lastNameFormItem, dateOfBirthFormItem, placeOfBirthFormItem]
    
    let loginSection = BaseTableViewFormSection()
    
    let loginSectionHeaderView: LeftTitleHeaderView = UIView.fromNib()
    loginSectionHeaderView.ibHeaderLabel.text = "Credentials".uppercased()
    
    loginSection.headerView = loginSectionHeaderView
    
    loginSection.items = [emailAddressFormItem, passwordFormItem]
    
    sections = [generalSection, loginSection]
  }
  
  override func registerCells(for tableView: UITableView) {
    SignUpCellType.registerCells(for: tableView)
  }
  
  @objc private func buttonAction() {
    actionButtonCallback?()
  }
  
  func getValues() -> SignUpFormValues? {
    
    var values = SignUpFormValues()
    
    if let firstName = firstNameFormItem.valueValidator.value {
      values.firstName =  firstName
    }
    
    if let lastName = lastNameFormItem.valueValidator.value {
      values.lastName = lastName
    }
    
    if let dateOfBirth = dateOfBirthFormItem.valueValidator.value {
      values.dateOfBirth = DateOfBirthFormItem.dateFormatter.string(from: dateOfBirth)
    }
    
    if let placeOfBirth = placeOfBirthFormItem.valueValidator.value {
      values.placeOfBirth = placeOfBirth
    }
    
    if let emailAddress = emailAddressFormItem.valueValidator.value {
      values.emailAddress = emailAddress
    }
    
    if let password = passwordFormItem.valueValidator.value {
      values.password = password
    }
    
    return values
  }
}

struct SignUpFormValues {
  var firstName: String = "nil"
  var lastName: String = "nil"
  var dateOfBirth: String = "nil"
  var placeOfBirth: String = "nil"
  var emailAddress: String = "nil"
  var password: String = "nil"
}


