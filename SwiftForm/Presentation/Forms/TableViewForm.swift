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

extension TableViewFormSection {
  public var headerView: UIView? {
    return UIView(frame: CGRect(origin: .zero, size: CGSize(width: CGFloat.leastNonzeroMagnitude, height: CGFloat.leastNonzeroMagnitude)))
  }
  
  public var footerView: UIView? {
    return UIView(frame: CGRect(origin: .zero, size: CGSize(width: CGFloat.leastNonzeroMagnitude, height: CGFloat.leastNonzeroMagnitude)))
  }
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

open class BaseTableViewForm: BaseForm, TableViewForm {
  
  public var tableHeaderView: UIView?
  public var tableFooterView: UIView?
  
  private var tableViewFormDelegate: TableViewFormDelegate? {
    return formDelegate as? TableViewFormDelegate
  }
  
  override func focusOnNextItem() {
    guard let editingFormItem = editingFormItem else {
      return
    }
    
    let currentIndexPath = editingFormItem.indexPath
    
    editingFormItem.endEditing()
    
    guard let formItem = nextFormItem(after: currentIndexPath, typeMask: focusableItems) else {
      return
    }
    
    tableViewFormDelegate?.scrollToNextFormItem(at: formItem.indexPath)
    
    formItem.beginEditing()
  }
  
  /// Register the form items cell
  ///
  /// You must provide a custom implementation otherwise the library will throw a failure.
  /// - Parameter tableView: the table view
  open func registerCells(for tableView: UITableView) {
    preconditionFailure("You must implement this method in subclass")
  }
}

open class BaseTableViewFormSection: BaseFormSection, TableViewFormSection {
  open var headerView: UIView?
  open var footerView: UIView?
}
