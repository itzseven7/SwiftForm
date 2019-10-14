//
//  TableViewFormContainer.swift
//  SwiftForm
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

protocol TableViewFormContainer: UITableViewDataSource {
  var table: UITableView { get }
  
  var form: TableViewForm? { get }
  
  // we put all formtableviewcontroller implementations here
}

extension TableViewFormContainer {
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
}
