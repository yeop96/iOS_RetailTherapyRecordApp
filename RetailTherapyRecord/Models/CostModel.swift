//
//  CostModel.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2021/11/19.
//

import Foundation
import RealmSwift // 10.18.0 exact version

//https://docs.mongodb.com/realm/sdk/ios/quick-start Realm 문서

class CostList: Object {
    @Persisted var costSubject: String
    @Persisted var costMoney: Int?
    @Persisted var costContent: String?
    @Persisted var costDate = Date()
    //@Persisted var costEmoji: String
    @Persisted(primaryKey: true) var _pk: ObjectId
    
    convenience init(costSubject: String, costMoney: Int, costContent: String, costDate: Date) { //,costEmoji: String
        self.init()
        
        self.costSubject = costSubject
        self.costMoney = costMoney
        self.costContent = costContent
        self.costDate = costDate
        //self.costEmoji = costEmoji
    }
}
