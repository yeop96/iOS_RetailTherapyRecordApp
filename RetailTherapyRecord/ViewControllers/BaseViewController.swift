//
//  BaseViewController.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2022/04/05.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBarFontSet()
    }
    
    func configure(){
    }
    
    func setupConstraints(){
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func navigationBarFontSet(){
        let attribute :[NSAttributedString.Key: Any] = [NSAttributedString.Key.font : UIFont().customFont_Navigation]
        
        if #available(iOS 15, *) {
            let naviAppearance = UINavigationBarAppearance()
            naviAppearance.titleTextAttributes = attribute
            naviAppearance.largeTitleTextAttributes = attribute
            
            self.navigationController?.navigationBar.standardAppearance = naviAppearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = naviAppearance
        } else{
            self.navigationController?.navigationBar.titleTextAttributes = attribute
        }
        
    }
    
    func tabBarFontSet(){
        let appearance = UITabBarAppearance()
        let attribute :[NSAttributedString.Key: Any] = [NSAttributedString.Key.font : UIFont().customFont_Navigation]
        appearance.configureWithOpaqueBackground()
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = attribute
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = attribute
        appearance.inlineLayoutAppearance.normal.titleTextAttributes = attribute
        appearance.inlineLayoutAppearance.selected.titleTextAttributes = attribute
        appearance.compactInlineLayoutAppearance.normal.titleTextAttributes = attribute
        appearance.compactInlineLayoutAppearance.selected.titleTextAttributes = attribute
        
        if #available(iOS 15.0, *) {
            self.tabBarController?.tabBar.standardAppearance = appearance
            self.tabBarController?.tabBar.scrollEdgeAppearance = appearance
        } else {
            self.tabBarController?.tabBar.standardAppearance = appearance
        }
    }
    
    func tabBarHiddenSet(hidden: Bool){
        self.tabBarController?.tabBar.isHidden = hidden
        MainTabBarController.actionButton.isHidden = hidden
    }
    
}
