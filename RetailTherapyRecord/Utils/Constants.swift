//
//  Constants.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2021/11/21.
//

import Foundation

enum Expression : Int {
    case expressionless = 0
    case pout = 1
    case angry = 2
    case meltdown = 3
    case sad = 4
    case flex = 5
    case calm = 6
    
    func expressionEmoji() -> String{
        switch self {
        case .expressionless:
            return "😶"
        case .pout:
            return "😤"
        case .angry:
            return "🤬"
        case .meltdown:
            return "🤯"
        case .sad:
            return "😢"
        case .flex:
            return "🤑"
        case .calm:
            return "☺️"
        }
    }
}
