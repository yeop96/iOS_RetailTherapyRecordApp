//
//  Bundle+Extension.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2022/05/03.
//

import Foundation

//MyPrivacyInfo.plist는 .gitignore한 상태
extension Bundle {
    var appAppleID: String {
        guard let file = self.path(forResource: "MyPrivacyInfo", ofType: "plist") else { fatalError("MyPrivacyInfo.plist 파일이 없습니다.") }
        guard let resource = NSDictionary(contentsOfFile: file) else { fatalError("파일 형식 에러") }
        guard let key = resource["AppAppleID"] as? String else { fatalError("MyPrivacyInfo에 AppAppleID을 설정해주세요.")}
        return key
    }
    
    var openSourceLicenseURL: String {
        guard let file = self.path(forResource: "MyPrivacyInfo", ofType: "plist") else { fatalError("MyPrivacyInfo.plist 파일이 없습니다.") }
        guard let resource = NSDictionary(contentsOfFile: file) else { fatalError("파일 형식 에러") }
        guard let key = resource["OpenSourceLicenseURL"] as? String else { fatalError("MyPrivacyInfo에 OpenSourceLicenseURL을 설정해주세요.")}
        return key
    }
    
    var appStoryURL: String {
        guard let file = self.path(forResource: "MyPrivacyInfo", ofType: "plist") else { fatalError("MyPrivacyInfo.plist 파일이 없습니다.") }
        guard let resource = NSDictionary(contentsOfFile: file) else { fatalError("파일 형식 에러") }
        guard let key = resource["AppStoryURL"] as? String else { fatalError("MyPrivacyInfo에 AppStoryURL을 설정해주세요.")}
        return key
    }
    
    var myEmail: String {
        guard let file = self.path(forResource: "MyPrivacyInfo", ofType: "plist") else { fatalError("MyPrivacyInfo.plist 파일이 없습니다.") }
        guard let resource = NSDictionary(contentsOfFile: file) else { fatalError("파일 형식 에러") }
        guard let key = resource["MyEmail"] as? String else { fatalError("MyPrivacyInfo에 MyEmail을 설정해주세요.")}
        return key
    }
}
