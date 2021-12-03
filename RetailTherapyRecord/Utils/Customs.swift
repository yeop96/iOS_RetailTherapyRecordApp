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
            return .strawberryMilk
        case .customView:
            return .clear
        case .success:
            return .primary
        case .warning:
            return .strawberryMilk
        }
    }
}
