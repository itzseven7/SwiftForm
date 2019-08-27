//
//  TestViewController.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit
import SwiftForm

enum CellType: TableViewFormItemCellType {
  
  case textField
  case textView
  case datePickerInput
  case pickerInput
  
  func dequeueCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
    switch self {
    case .textField:
      return tableView.dequeueReusableCell(withIdentifier: String(describing: TextFieldTableViewCell.self), for: indexPath)
    case .textView:
      return tableView.dequeueReusableCell(withIdentifier: String(describing: TextViewTableViewCell.self), for: indexPath)
    case .datePickerInput:
      return tableView.dequeueReusableCell(withIdentifier: String(describing: DatePickerFieldTableViewCell.self), for: indexPath)
    case .pickerInput:
      return tableView.dequeueReusableCell(withIdentifier: String(describing: PickerViewFieldTableViewCell.self), for: indexPath)
    }
  }
}

class TestForm: BaseTableViewForm {
  
  var tableHeaderView: UIView?
  
  override init() {
    super.init()
    
    let headerView: HeaderView = UIView.fromNib()
    headerView.ibTitleLabel.text = "SignUp Form"
    headerView.ibDescriptionLabel.text = "This form demonstrates the library power"
    tableHeaderView = headerView
    
    let generalSection = BaseTableViewFormSection()
    
    let generalSectionHeaderView: LeftTitleHeaderView = UIView.fromNib()
    generalSectionHeaderView.ibHeaderLabel.text = "General"
    
    generalSection.headerView = generalSectionHeaderView
    
    generalSection.items = [FirstNameFormItem(value: "Romain"), LastNameFormItem(), DateOfBirthFormItem(), PlaceOfBirthFormItem()]
    
    let loginSection = BaseTableViewFormSection()
    
    let loginSectionHeaderView: LeftTitleHeaderView = UIView.fromNib()
    loginSectionHeaderView.ibHeaderLabel.text = "Credentials"
    
    loginSection.headerView = loginSectionHeaderView
    
    loginSection.items = [EmailAddressFormItem(), PasswordFormItem()]
    
    sections = [generalSection, loginSection]
  }
  
  override func registerCells(for tableView: UITableView) {
    tableView.register(UINib(nibName: String(describing: TextFieldTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TextFieldTableViewCell.self))
    tableView.register(UINib(nibName: String(describing: TextViewTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TextFieldTableViewCell.self))
    tableView.register(UINib(nibName: String(describing: DatePickerFieldTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: DatePickerFieldTableViewCell.self))
    tableView.register(UINib(nibName: String(describing: PickerViewFieldTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: PickerViewFieldTableViewCell.self))
  }
}

final class TestViewController: FormTableViewController  {
  override func viewDidLoad() {
    form = TestForm()
    
    super.viewDidLoad()
    
    tableView.beginUpdates()
    tableView.endUpdates()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    //form?.beginEditing()
  }
}
