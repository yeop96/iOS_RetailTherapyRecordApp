//
//  Constants.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2021/11/21.
//

import UIKit

enum Expression: Int, CaseIterable {
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

enum CustomUserFont: Int {
    case base = 0
    case nanum = 1
    case noto = 2
    case kcc = 3
}

enum SettingString: Int, CaseIterable {
    case openSourceLicense
    case contactUs
    case appStory
    case myFont
    case appStoreReview
    case appVersion
    
    func settingTitle() -> String{
        switch self {
        case .openSourceLicense:
            return "오픈소스 라이선스"
        case .contactUs:
            return "문의하기"
        case .appStory:
            return "앱 이야기"
        case .myFont:
            return "나의 글씨체"
        case .appStoreReview:
            return "앱 리뷰 이동"
        case .appVersion:
            return "앱 버전"
        }
    }
    
}
