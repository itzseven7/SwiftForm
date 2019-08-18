//
//  TableViewForm.swift
//  SwiftForm
//
//  Created by Romain on 16/08/2019.
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

protocol TableViewForm: Form {
  var tableHeaderView: UIView? { get }
  
  var tableFooterView: UIView? { get }
  
  func registerCells(for tableView: UITableView)
}

protocol TableViewFormSection: FormSection {
  var headerView: UIView? { get }
  var footerView: UIView? { get }
}

protocol TableViewFormDelegate: FormDelegate {
  func scrollToNextFormItem(at indexPath: IndexPath)
}

protocol FormItemTableViewModel: FormItem {
  var cellType: FormItemCellType { get }
}

protocol FormItemCellType {
  func dequeueCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
}

extension TableViewForm {
  var tableHeaderView: UIView? {
    return UIView(frame: CGRect(origin: .zero, size: CGSize(width: CGFloat.leastNonzeroMagnitude, height: CGFloat.leastNonzeroMagnitude)))
  }
  
  var tableFooterView: UIView? {
    return UIView(frame: CGRect(origin: .zero, size: CGSize(width: CGFloat.leastNonzeroMagnitude, height: CGFloat.leastNonzeroMagnitude)))
  }
}



class BaseTableViewForm: BaseForm, TableViewForm {
  
  func registerCells(for tableView: UITableView) {}
}

class BaseTableViewFormSection: BaseFormSection, TableViewFormSection {
  
  var headerView: UIView?
  var footerView: UIView?
}
