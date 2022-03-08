//
//  UITableViewCell+Extension.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2022/01/18.
//

import UIKit

protocol Reusableview{
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: Reusableview{
    
    static var reuseIdentifier: String{
        return String(describing: self)
    }
}
