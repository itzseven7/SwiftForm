//
//  UITableView+Extension.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

extension UITableView {
  func layoutTableHeaderView() {
    if let headerView = tableHeaderView {
      let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
      var headerFrame = headerView.frame
      
      if height != headerFrame.size.height {
        headerFrame.size.height = height
        headerView.frame = headerFrame
        tableHeaderView = headerView
      }
    }
  }
  
  func layoutTableFooterView() {
    if let footerView = tableFooterView {
      let height = footerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
      var footerFrame = footerView.frame
      
      if height != footerFrame.size.height {
        footerFrame.size.height = height
        footerView.frame = footerFrame
        tableFooterView = footerView
      }
    }
  }
}
