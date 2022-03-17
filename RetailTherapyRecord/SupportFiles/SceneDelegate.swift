//
//  SceneDelegate.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2021/11/19.
//

import UIKit
import AppTrackingTransparency
import FirebaseAnalytics

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            //ATT Framework
            if #available(iOS 14, *) {
                ATTrackingManager.requestTrackingAuthorization { status in
                    switch status{
                    case .notDetermined:
                        print("notDetermined")
                        Analytics.setAnalyticsCollectionEnabled(false)
                    case .restricted:
                        print("restricted")
                        Analytics.setAnalyticsCollectionEnabled(false)
                    case .denied:
                        print("denied")
                        Analytics.setAnalyticsCollectionEnabled(false)
                    case .authorized:
                        print("authorized") //애널리틱스 수집 가능
                        Analytics.setAnalyticsCollectionEnabled(true)
                    @unknown default:
                        print("unknown")
                        Analytics.setAnalyticsCollectionEnabled(false)
                    }
                }
            } else {
                // Fallback on earlier versions
            }
        }
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }


}

