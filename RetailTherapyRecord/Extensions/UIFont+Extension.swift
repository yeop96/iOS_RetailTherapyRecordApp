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

//        KCC-Kimhwanki
//        ====> KCC-Kimhwanki 김환기체


extension UIFont{
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
        return UIFont.systemFont(ofSize: fontSize - 2)
    case CustomUserFont.nanum.rawValue:
        return UIFont(name: "NanumBaReunHiPi", size: fontSize)!
    case CustomUserFont.noto.rawValue:
        return UIFont(name: "NotoSansCJKkr-Regular", size: fontSize - 2)!
    case CustomUserFont.kcc.rawValue:
        return UIFont(name: "KCC-Kimhwanki", size: fontSize)!
    default:
        return UIFont(name: "NanumBaReunHiPi", size: fontSize)!
    }
}
