//
//  FontSettingController.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2022/03/31.
//


import UIKit

final class FontSettingViewController: UIViewController{
    @IBOutlet var radioButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "나의 글씨체"
        self.navigationController?.navigationBar.titleTextAttributes = [.font: UIFont().customFont21]
        
    }
    
}
