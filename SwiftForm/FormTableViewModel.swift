//
//  FormTableViewModel.swift
//  SwiftForm
//
//  Created by Romain on 16/08/2019.
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

protocol FormTableViewModel: FormViewModel {
  var tableHeaderView: UIView? { get }
  
  var tableFooterView: UIView? { get }
  
  func registerCells(for tableView: UITableView)
}

protocol FormItemTableViewModel: FormItemViewModel {
  var cellType: FormItemCellType { get }
}

protocol FormItemCellType {
  func dequeueCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
}

extension FormTableViewModel {
  var tableHeaderView: UIView? {
    return UIView(frame: CGRect(origin: .zero, size: CGSize(width: CGFloat.leastNonzeroMagnitude, height: CGFloat.leastNonzeroMagnitude)))
  }
  
  var tableFooterView: UIView? {
    return UIView(frame: CGRect(origin: .zero, size: CGSize(width: CGFloat.leastNonzeroMagnitude, height: CGFloat.leastNonzeroMagnitude)))
  }
}



class BaseFormTableViewModel: BaseFormViewModel, FormTableViewModel {
  
  func registerCells(for tableView: UITableView) {}
}

class FormSectionTableViewModel: FormSectionViewModel {
  var items: [FormItemViewModel] = []
  
  var headerView: UIView?
  var footerView: UIView?
}
