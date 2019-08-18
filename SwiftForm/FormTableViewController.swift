//
//  FormTableViewController.swift
//  SwiftForm
//
//  Copyright © 2019 Healsy. All rights reserved.
//

import UIKit

class FormTableViewController: UIViewController, TableViewFormDelegate, UITableViewDataSource, UITableViewDelegate {
  
  var tableView: UITableView!
  
  var form: TableViewForm?
  
  /// Cache for cells height
  fileprivate var heightDictionary: [IndexPath: CGFloat] = [:]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView = UITableView(frame: view.frame, style: .grouped)
    
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.tableHeaderView = form?.tableHeaderView
    tableView.tableHeaderView?.layoutIfNeeded()
    
    tableView.tableFooterView = form?.tableFooterView
    tableView.tableFooterView?.layoutIfNeeded()
    
    view.addSubview(tableView)
    
    form?.delegate = self
    
    form?.registerCells(for: tableView)
    
    tableView.rowHeight = UITableView.automaticDimension
    tableView.sectionHeaderHeight = UITableView.automaticDimension
    tableView.sectionFooterHeight = UITableView.automaticDimension
    tableView.isDirectionalLockEnabled = true
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return form?.sections.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return form?.sections[section].items.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let formItem = form?.formItem(at: indexPath) as? FormItemTableViewModel else {
      fatalError("Should have a valid form item here")
    }
    
    return formItem.cellType.dequeueCell(for: tableView, at:indexPath)
  }
  
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let formSection = form?.sections[section] as? TableViewFormSection else { return nil }
    return formSection.headerView
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    guard let formSection = form?.sections[section] as? TableViewFormSection, formSection.headerView != nil else { return .leastNonzeroMagnitude }
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    guard let formSection = form?.sections[section] as? TableViewFormSection else { return nil }
    return formSection.footerView
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    guard let formSection = form?.sections[section] as? TableViewFormSection, formSection.footerView != nil else { return .leastNonzeroMagnitude }
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    heightDictionary[indexPath] = cell.frame.size.height
    
    // configure cell here
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    let height = heightDictionary[indexPath]
    return height ?? UITableView.automaticDimension
  }
  
  func formSectionsDidBecomeVisible(_ formSections: [FormSection]) {
    tableView.beginUpdates()
    tableView.insertSections(IndexSet(formSections.compactMap { $0.items.first?.indexPath.section }), with: .automatic)
    tableView.endUpdates()
  }
  
  func formSectionsDidHide(_ formSections: [FormSection]) {
    tableView.beginUpdates()
    tableView.deleteSections(IndexSet(formSections.compactMap { $0.items.first?.indexPath.section }), with: .automatic)
    tableView.endUpdates()
  }
  
  func formItemsDidUpdate(_ formItems: [FormItem]) {
    tableView.beginUpdates()
    tableView.reloadRows(at: formItems.map { $0.indexPath }, with: .automatic)
    tableView.endUpdates()
  }
  
  func formItemsDidBecomeVisible(_ formItems: [FormItem]) {
    tableView.beginUpdates()
    tableView.insertRows(at: formItems.map { $0.indexPath }, with: .automatic)
    tableView.endUpdates()
  }
  
  func formItemsDidHide(_ formItems: [FormItem]) {
    tableView.beginUpdates()
    tableView.deleteRows(at: formItems.map { $0.indexPath }, with: .automatic)
    tableView.endUpdates()
  }
  
  func scrollToNextFormItem(at indexPath: IndexPath) {
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
