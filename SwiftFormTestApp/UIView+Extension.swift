//
//  UIView+Extension.swift
//  SwiftFormTestApp
//
//  Copyright © 2019 itzseven. All rights reserved.
//

import UIKit

extension UIView {
  class func fromNib<T: UIView>() -> T {
    return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
  }
  
  func shake(for duration: TimeInterval = 0.4, withTranslation translation: CGFloat = 4) {
    let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
      self.transform = CGAffineTransform(translationX: translation, y: 0)
    }
    
    propertyAnimator.addAnimations({
      self.transform = CGAffineTransform(translationX: -translation, y: 0)
    }, delayFactor: 0.1)
    
    propertyAnimator.addAnimations({
      self.transform = CGAffineTransform(translationX: 0, y: 0)
    }, delayFactor: 0.2)
    
    propertyAnimator.startAnimation()
  }
}
