//
//  FontSettingController.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2022/03/31.
//


import UIKit

final class FontSettingViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "나의 글씨체"
        self.navigationController?.navigationBar.titleTextAttributes = [.font: UIFont().customFont21]
        
    }
    
}
