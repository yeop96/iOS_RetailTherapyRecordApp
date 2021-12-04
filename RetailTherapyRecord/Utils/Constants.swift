//
//  Constants.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2021/11/21.
//

import Foundation
import UIKit


enum Expression : Int {
    case rich = 0
    case smile = 1
    case angry = 2
    case cry = 3
    case sad = 4
    case yummy = 5
    case expressionless = 6
    
    func expressionEmoji() -> UIImage{
        switch self {
        case .rich:
            return UIImage(named: "rich")!
        case .smile:
            return UIImage(named: "smile")!
        case .angry:
            return UIImage(named: "angry")!
        case .cry:
            return UIImage(named: "cry")!
        case .sad:
            return UIImage(named: "sad")!
        case .yummy:
            return UIImage(named: "yummy")!
        case .expressionless:
            return UIImage(named: "expressionless")!
        }
    }
    
}
