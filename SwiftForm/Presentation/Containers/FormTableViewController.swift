//
//  FormTableViewController.swift
//  SwiftForm
//
//  Copyright © 2019 Healsy. All rights reserved.
//

import UIKit

open class FormTableViewController: UIViewController, TableViewFormDelegate, UITableViewDataSource, UITableViewDelegate {
  
  open var tableView: UITableView {
    preconditionFailure("You must provide your own table view")
  }
  
  open var form: TableViewForm?
  
  /// Cache for cells height
  fileprivate var heightDictionary: [IndexPath: CGFloat] = [:]
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  override open func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.tableHeaderView = form?.tableHeaderView
    tableView.tableFooterView = form?.tableFooterView
    
    form?.formDelegate = self
    form?.registerCells(for: tableView)
  }
  
  public func numberOfSections(in tableView: UITableView) -> Int {
    return form?.sections.count ?? 0
  }
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return form?.sections[section].items.count ?? 0
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let formItem = form?.formItem(at: indexPath) as? TableViewFormItem else {
      fatalError("Should have a valid form item here")
    }
    
    return formItem.cellType.dequeueCell(for: tableView, at:indexPath)
  }
  
  public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let formSection = form?.sections[section] as? TableViewFormSection else { return nil }
    return formSection.headerView
  }
  
  public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    guard let formSection = form?.sections[section] as? TableViewFormSection, formSection.headerView != nil else { return .leastNonzeroMagnitude }
    return UITableView.automaticDimension
  }
  
  public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    guard let formSection = form?.sections[section] as? TableViewFormSection else { return nil }
    return formSection.footerView
  }
  
  public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    guard let formSection = form?.sections[section] as? TableViewFormSection, formSection.footerView != nil else { return .leastNonzeroMagnitude }
    return UITableView.automaticDimension
  }
  
  public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //heightDictionary[indexPath] = cell.frame.size.height
    
    guard let formItem = form?.formItem(at: indexPath) as? TableViewFormItem else {
      fatalError("Should have a valid form item here")
    }
    
    guard let container = cell as? FormItemContainer else {
      assertionFailure("Cell must be a form item container")
      return
    }
    
    container.formItem = formItem
    container.setUp()
  }
  
//  public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//    let height = heightDictionary[indexPath]
//    return height ?? UITableView.automaticDimension
//  }
  
  open func formSectionsDidBecomeVisible(_ formSections: [FormSection]) {
    tableView.beginUpdates()
    tableView.insertSections(IndexSet(formSections.compactMap { $0.items.first?.indexPath.section }), with: .automatic)
    tableView.endUpdates()
  }
  
  open func formSectionsDidHide(_ formSections: [FormSection]) {
    tableView.beginUpdates()
    tableView.deleteSections(IndexSet(formSections.compactMap { $0.items.first?.indexPath.section }), with: .automatic)
    tableView.endUpdates()
  }
  
  open func formItemsDidUpdate(_ formItems: [FormItem]) {
    UIView.setAnimationsEnabled(false)
    tableView.beginUpdates()
    tableView.endUpdates()
    UIView.setAnimationsEnabled(true)
  }
  
  open func formItemsDidBecomeVisible(_ formItems: [FormItem]) {
    tableView.beginUpdates()
    tableView.insertRows(at: formItems.map { $0.indexPath }, with: .automatic)
    tableView.endUpdates()
  }
  
  open func formItemsDidHide(_ formItems: [FormItem]) {
    tableView.beginUpdates()
    tableView.deleteRows(at: formItems.map { $0.indexPath }, with: .automatic)
    tableView.endUpdates()
  }
  
  open func scrollToNextFormItem(at indexPath: IndexPath) {
    _ = tableView.visibleCells
    
    if let visibleRows = tableView.indexPathsForVisibleRows, visibleRows.contains(indexPath) {
      let cellRect = tableView.rectForRow(at: indexPath)
      let completelyVisible = tableView.bounds.contains(cellRect)
      if !completelyVisible {
        tableView.scrollToRow(at: indexPath, at: .none, animated: true)
      } else {
        return
      }
    } else {
      tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
  }
}
