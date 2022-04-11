//
//  UIFont+Extension.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2021/12/04.
//

import UIKit

//        Nanum BaReunHiPi
//        =========> NanumBaReunHiPi 나눔히피 폰트

//        Noto Sans CJK KR
//        =========> NotoSansCJKKr-Medium
//        =========> NotoSansCJKkr-Regular

extension UIFont{
    var nanumFont12: UIFont {
        return UIFont(name: "NanumBaReunHiPi", size: 12)!
    }
    var nanumFont15: UIFont {
        return UIFont(name: "NanumBaReunHiPi", size: 15)!
    }
    var nanumFont17: UIFont {
        return UIFont(name: "NanumBaReunHiPi", size: 17)!
    }
    var nanumFont18: UIFont {
        return UIFont(name: "NanumBaReunHiPi", size: 18)!
    }
    var nanumFont21: UIFont {
        return UIFont(name: "NanumBaReunHiPi", size: 21)!
    }
    var nanumFont24: UIFont {
        return UIFont(name: "NanumBaReunHiPi", size: 24)!
    }
}


extension UIFont{
    var customFont12: UIFont {
        customFontSize(fontSize: 12)
    }
    var customFont15: UIFont {
        customFontSize(fontSize: 15)
    }
    var customFont17: UIFont {
        customFontSize(fontSize: 17)
    }
    var customFont18: UIFont {
        customFontSize(fontSize: 18)
    }
    var customFont21: UIFont {
        customFontSize(fontSize: 21)
    }
    var customFont24: UIFont {
        customFontSize(fontSize: 24)
    }
    
    var customFont_Title: UIFont {
        customFontSize(fontSize: 18)
    }
    var customFont_Content: UIFont {
        customFontSize(fontSize: 17)
    }
    var customFont_Record: UIFont {
        customFontSize(fontSize: 15)
    }
    var customFont_Header: UIFont {
        customFontSize(fontSize: 12)
    }
    var customFont_Navigation: UIFont {
        customFontSize(fontSize: 21)
    }
    var customFont_Big: UIFont {
        customFontSize(fontSize: 24)
    }
}

func customFontSize(fontSize: CGFloat) -> UIFont{
    switch UserData.customUserFont {
    case CustomUserFont.base.rawValue:
        return UIFont.systemFont(ofSize: fontSize - 3)
    case CustomUserFont.nanum.rawValue:
        return UIFont(name: "NanumBaReunHiPi", size: fontSize)!
    case CustomUserFont.noto.rawValue:
        return UIFont(name: "NotoSansCJKkr-Regular", size: fontSize - 3)!
    default:
        return UIFont(name: "NanumBaReunHiPi", size: fontSize)!
    }
}
