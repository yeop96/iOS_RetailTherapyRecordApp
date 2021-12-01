//
//  UITextField+Extension.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2021/12/02.
//

import Foundation
import UIKit

extension UITextField {
    
  func addLeftPadding() {
      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
      self.leftView = paddingView
      self.leftViewMode = ViewMode.always
  }
    
}
