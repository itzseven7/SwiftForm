//
//  HeaderView.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

class HeaderView: UIView  {
  @IBOutlet weak var ibTitleLabel: UILabel!
  @IBOutlet weak var ibDescriptionLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    backgroundColor = UIColor(red: 237/255, green: 236/255, blue: 243/255, alpha: 1)
    ibTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    ibTitleLabel.textColor = .gray
    ibDescriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    ibDescriptionLabel.textColor = .gray
  }
}
