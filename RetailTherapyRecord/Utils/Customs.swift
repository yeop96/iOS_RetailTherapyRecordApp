//
//  Customs.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2021/12/03.
//

import Foundation
import UIKit
import NotificationBannerSwift

class CustomBannerColors: BannerColorsProtocol {
    internal func color(for style: BannerStyle) -> UIColor {
        switch style {
        case .danger:
            return .strawberryMilk
        case .info:
            return .primary
        case .customView:
            return .clear
        case .success:
            return .green
        case .warning:
            return .strawberryMilk
        }
    }
}
