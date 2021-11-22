//
//  DateFormatter+Extension.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2021/11/23.
//

import Foundation

extension DateFormatter {
    
    func koreaDateFormatString(date : Date) -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:"ko_KR")
        dateFormatter.dateFormat = "yyyy년 M월 d일"
        let str = dateFormatter.string(from: date)
        
        return str
    }
    
    
}
