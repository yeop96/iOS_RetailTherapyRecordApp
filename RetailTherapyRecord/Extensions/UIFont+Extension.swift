//
//  UIFont+Extension.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2021/12/04.
//

import UIKit

//        Nanum BaReunHiPi
//        =========> NanumBaReunHiPi 나눔히피 폰트

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

//        Noto Sans CJK KR

extension UIFont{
    var Display1_R20: UIFont {
        return UIFont(name: "NotoSansCJKKr-Regular", size: 20)!
    }
    var Title1_M16: UIFont {
        return UIFont(name: "NotoSansCJKkr-Medium", size: 16)!
    }
    var Title2_R16: UIFont {
        return UIFont(name: "NotoSansCJKkr-Regular", size: 16)!
    }
    var Title3_M14: UIFont {
        return UIFont(name: "NotoSansCJKkr-Medium", size: 14)!
    }
    var Title4_R14: UIFont {
        return UIFont(name: "NotoSansCJKkr-Regular", size: 14)!
    }
    var Title5_M12: UIFont {
        return UIFont(name: "NotoSansCJKkr-Medium", size: 12)!
    }
    var Title6_R12: UIFont {
        return UIFont(name: "NotoSansCJKkr-Regular", size: 12)!
    }
    var Body1_M16: UIFont {
        return UIFont(name: "NotoSansCJKkr-Medium", size: 16)!
    }
    var Body2_R16: UIFont {
        return UIFont(name: "NotoSansCJKkr-Regular", size: 16)!
    }
    var Body3_R14: UIFont {
        return UIFont(name: "NotoSansCJKkr-Regular", size: 14)!
    }
    var Body4_R12: UIFont {
        return UIFont(name: "NotoSansCJKkr-Regular", size: 12)!
    }
    var caption_R10: UIFont {
        return UIFont(name: "NotoSansCJKkr-Regular", size: 10)!
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
    var customFont_Navigation: UIFont {
        customFontSize(fontSize: 21)
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
