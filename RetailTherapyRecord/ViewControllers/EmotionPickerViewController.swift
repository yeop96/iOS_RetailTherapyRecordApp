//
//  EmotionPickerViewController.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2021/11/22.
//

import UIKit

class EmotionPickerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        
        self.dismiss(animated: true)
    }
    
    
}
