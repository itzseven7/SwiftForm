//
//  TableViewForm.swift
//  SwiftForm
//
//  Created by Romain on 16/08/2019.
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

public protocol TableViewForm: Form {
  var tableHeaderView: UIView? { get }
  
  var tableFooterView: UIView? { get }
  
  func registerCells(for tableView: UITableView)
}

public protocol TableViewFormSection: FormSection {
  var headerView: UIView? { get }
  var footerView: UIView? { get }
}

public protocol TableViewFormDelegate: FormDelegate {
  func scrollToNextFormItem(at indexPath: IndexPath)
}

public protocol TableViewFormItem: FormItem {
  var cellType: TableViewFormItemCellType { get }
}

public protocol TableViewFormItemCellType {
  func dequeueCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
}

extension TableViewForm {
  public var tableHeaderView: UIView? {
    return UIView(frame: CGRect(origin: .zero, size: CGSize(width: CGFloat.leastNonzeroMagnitude, height: CGFloat.leastNonzeroMagnitude)))
  }
  
  public var tableFooterView: UIView? {
    return UIView(frame: CGRect(origin: .zero, size: CGSize(width: CGFloat.leastNonzeroMagnitude, height: CGFloat.leastNonzeroMagnitude)))
  }
}

open class BaseTableViewForm: BaseForm, TableViewForm {
  
  open func registerCells(for tableView: UITableView) {
    preconditionFailure("You must implement this method in subclass")
  }
}

open class BaseTableViewFormSection: BaseFormSection, TableViewFormSection {
  
  open var headerView: UIView?
  open var footerView: UIView?
}
