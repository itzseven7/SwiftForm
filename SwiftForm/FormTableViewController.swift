//
//  FormTableViewController.swift
//  SwiftForm
//
//  Copyright © 2019 Healsy. All rights reserved.
//

import UIKit

class FormTableViewController: UIViewController, FormTableViewModelDelegate, UITableViewDataSource, UITableViewDelegate {
  
  var tableView: UITableView!
  
  var viewModel: FormTableViewModel?
  
  /// Cache for cells height
  fileprivate var heightDictionary: [IndexPath: CGFloat] = [:]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView = UITableView(frame: view.frame, style: .grouped)
    
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.tableHeaderView = viewModel?.tableHeaderView
    tableView.tableHeaderView?.layoutIfNeeded()
    
    tableView.tableFooterView = viewModel?.tableFooterView
    tableView.tableFooterView?.layoutIfNeeded()
    
    view.ex.addSubview(tableView)
    
    viewModel?.delegate = self
    
    viewModel?.registerCells(for: tableView)
    
    tableView.rowHeight = UITableView.automaticDimension
    tableView.sectionHeaderHeight = UITableView.automaticDimension
    tableView.sectionFooterHeight = UITableView.automaticDimension
    tableView.isDirectionalLockEnabled = true
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel?.sections.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel?.sections[section].visibleItems.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let formItemViewModel = viewModel?.visibleFormItemViewModel(at: indexPath) as? FormItemTableViewModelProtocol else {
      fatalError("Should have a valid form item here")
    }
    let cell = formItemViewModel.cellType.dequeueCell(for: tableView, at: indexPath)
    if let cell = cell as? FormItemContainerProtocol {
      cell.update(with: formItemViewModel)
    }
    
    cell.contentView.directionalLayoutMargins = formItemViewModel.directionalLayoutMargins
    
    return cell
  }
  
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let formSection = viewModel?.sections[section] as? FormSectionTableViewModel else { return nil }
    return formSection.headerView
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    guard let formSection = viewModel?.sections[section] as? FormSectionTableViewModel, formSection.headerView != nil else { return .leastNonzeroMagnitude }
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    guard let formSection = viewModel?.sections[section] as? FormSectionTableViewModel else { return nil }
    return formSection.footerView
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    guard let formSection = viewModel?.sections[section] as? FormSectionTableViewModel, formSection.footerView != nil else { return .leastNonzeroMagnitude }
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
  
  func formItemViewModelsDidUpdate(_ formItemViewModels: [FormItemViewModel]) {
    formItemViewModels.forEach {
      if let cell = tableView.cellForRow(at: $0.indexPath) as? FormItemContainerProtocol {
        cell.update(with: $0)
      }
    }
    
    UIView.performWithoutAnimation {
      tableView.beginUpdates()
      tableView.endUpdates()
      tableView.reloadData()
    }
  }
  
  func formItemViewModelsDidBecomeVisible(_ formItemViewModels: [FormItemViewModel]) {
    tableView.beginUpdates()
    tableView.insertRows(at: formItemViewModels.map { $0.indexPath }, with: .automatic)
    tableView.endUpdates()
  }
  
  func formItemViewModelsDidHide(_ formItemViewModels: [FormItemViewModel]) {
    tableView.beginUpdates()
    tableView.deleteRows(at: formItemViewModels.map { $0.indexPath }, with: .automatic)
    tableView.endUpdates()
  }
  
  func scrollToNextFormItemViewModel(atIndexPath indexPath: IndexPath?) {
    guard let indexPath = indexPath, tableView.containsIndexPath(indexPath) else {
      DispatchQueue.main.async {
        self.tableView.scrollToBottom(animated: true)
      }
      return
    }
    
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
