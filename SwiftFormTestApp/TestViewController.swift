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
  
  func dequeueCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCell(withIdentifier: String(describing: FormTextFieldTableViewCell.self), for: indexPath)
  }
}

class TestTextFieldFormItem: TextFieldFormItemInput<String>, TableViewFormItem {
  var cellType: TableViewFormItemCellType = CellType.textField
  
  override func validator(_ value: String?) -> ValueValidator<String> {
    return TestTextValidator(value: value)
  }
  
  override func value(from inputValue: String?) -> String? {
    return inputValue
  }
  
  override func inputValue(from value: String?) -> String? {
    return value
  }
  
  class TestTextValidator: TextValidator, TextValidatorErrorProvider {
    var emptyError: String? {
      return "You cannot put an empty value."
    }
    
    var noValueError: String? {
      return "You must fulfill this field."
    }
    
    override init(value: String?) {
      super.init(value: value)
      
      errorProvider = self
    }
  }
}

class TestForm: BaseTableViewForm {
  
  override init() {
    super.init()
    
    let sectionsInfos: [String: [String]] = [
      "First section" : ["First item", "Second item"],
      "Second section" : ["Third item"],
      "Third section" : ["Fourth item", "Fifth item", "Sixth item", "Seventh item", "Eight item", "Ninth item"]
    ]
    
    var newSections: [TableViewFormSection] = []
    
    for (section, items) in sectionsInfos.sorted(by: { $0.key < $1.key}) {
      let newSection = BaseTableViewFormSection()
      
      let sectionHeaderView: LeftTitleHeaderView = UIView.fromNib()
      sectionHeaderView.ibHeaderLabel.text = section
      
      newSection.headerView = sectionHeaderView
      
      for item in items {
        let newItem = TestTextFieldFormItem()
        newItem.title = item
        newItem.description = "Description multiline Description multiline Description multiline Description multiline Description multiline"
        
        newSection.items.append(newItem)
      }
      
      newSections.append(newSection)
    }
    
    sections = newSections
  }
  
  override func registerCells(for tableView: UITableView) {
    tableView.register(UINib(nibName: String(describing: FormTextFieldTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: FormTextFieldTableViewCell.self))
  }
}

class TestViewController: FormTableViewController  {
  override func viewDidLoad() {
    form = TestForm()
    
    super.viewDidLoad()
  }
}
