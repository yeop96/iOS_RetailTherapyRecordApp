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
    
    func configure(){
    }
    
    func setupConstraints(){
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func navigationBarFontSet(){
        if #available(iOS 15, *) {
            self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.font : UIFont().customFont_Navigation]
            self.navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [.font : UIFont().customFont_Navigation]
        } else{
            self.navigationController?.navigationBar.titleTextAttributes = [.font: UIFont().customFont_Navigation]
        }
    }
    
}
