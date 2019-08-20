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

class TestTextFieldFormItem: TextFieldFormItemInput<Int>, TableViewFormItem {
  var cellType: TableViewFormItemCellType = CellType.textField
  
  override func validator(_ value: Int?) -> ValueValidator<Int> {
    return ValueValidator(value: value)
  }
  
  override func value(from inputValue: String?) -> Int? {
    guard let inputValue = inputValue else { return nil }
    return Int(inputValue)
  }
  
  override func inputValue(from value: Int?) -> String? {
    guard let value = value else { return nil }
    return "\(value)"
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
    
    for (section, items) in sectionsInfos {
      let newSection = BaseTableViewFormSection()
      
      let sectionHeaderView: LeftTitleHeaderView = UIView.fromNib()
      sectionHeaderView.ibHeaderLabel.text = section
      
      newSection.headerView = sectionHeaderView
      
      for item in items {
        let newItem = TestTextFieldFormItem()
        newItem.title = item
        
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
