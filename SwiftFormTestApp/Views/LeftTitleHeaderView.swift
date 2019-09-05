//
//  LeftTitleHeaderView.swift
//  CPA-ios
//
//  Copyright © 2018 Healsy. All rights reserved.
//

import UIKit

final class LeftTitleHeaderView: UIView {
  
  // MARK: - Outlets
  @IBOutlet weak var ibHeaderLabel: UILabel!
  
  // MARK: - Initializers
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.commonInit()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.commonInit()
  }
  
  private func commonInit() {
    backgroundColor = UIColor.lightGray
  }
}
