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
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.commonInit()
  }
  
  private func commonInit() {
    backgroundColor = UIColor(red: 237/255, green: 236/255, blue: 243/255, alpha: 1)
    ibHeaderLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    ibHeaderLabel.textColor = .gray
  }
}
