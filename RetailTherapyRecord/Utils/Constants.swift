//
//  Constants.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2021/11/21.
//

import Foundation
import UIKit


enum Expression : Int {
    case expressionless = 0
    case smile = 1
    case angry = 2
    case cry = 3
    case sad = 4
    case stressed = 5
    case rich = 6
    
    func expressionEmoji() -> UIImage{
        switch self {
        case .expressionless:
            return UIImage(named: "expressionless")!
        case .smile:
            return UIImage(named: "smile")!
        case .angry:
            return UIImage(named: "angry")!
        case .cry:
            return UIImage(named: "cry")!
        case .sad:
            return UIImage(named: "sad")!
        case .stressed:
            return UIImage(named: "stressed")!
        case .rich:
            return UIImage(named: "rich")!
        }
    }
    
    
}
