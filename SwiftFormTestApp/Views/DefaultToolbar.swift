//
//  DefaultToolbar.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

class DefaultToolbar: UIView {
  @IBOutlet weak var ibLeftButton: UIButton!
  @IBOutlet weak var ibRightButton: UIButton!
  @IBOutlet weak var ibTitleLabel: UILabel!
  
  var leftButtonActionCallback: (() -> Void)?
  var rightButtonActionCallback: (() -> Void)?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    ibLeftButton.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
    ibRightButton.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
  }
  
  func setTitle(_ title: String?) {
    ibTitleLabel.text = title
    ibTitleLabel.isHidden = title == nil
  }
  
  @objc func leftButtonAction() {
    leftButtonActionCallback?()
  }
  
  @objc func rightButtonAction() {
    rightButtonActionCallback?()
  }
}
