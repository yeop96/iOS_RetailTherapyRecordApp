//
//  UserDefault.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2022/03/08.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            // Read value from UserDefaults
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            // Set value to UserDefaults
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

struct AppFirstLaunch {
    @UserDefault(key: keyEnum.isAppFirstLaunch.rawValue, defaultValue: true)
    static var isAppFirstLaunch: Bool
}

enum keyEnum: String {
    case isAppFirstLaunch = "isAppFirstLaunch"
}
