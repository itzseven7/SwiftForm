//
//  LeftTitleFooterView.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

final class LeftTitleFooterView: UIView {
  @IBOutlet weak var ibFooterLabel: UILabel!
  
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
    backgroundColor = UIColor(red: 237/255, green: 236/255, blue: 243/255, alpha: 1)
  }
}
