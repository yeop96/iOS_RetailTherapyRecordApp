//
//  RecordViewController.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2021/11/20.
//

import UIKit

class RecordViewController: UIViewController {
    var editRecordBool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "기록"
        
        if !editRecordBool{
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissAction))
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(saveButtonClicked))
        
    }
    
    @objc func saveButtonClicked(){
        if editRecordBool{
            
            self.navigationController?.popViewController(animated: true)
        }
        else{
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func dismissAction(){
        self.dismiss(animated: true, completion: nil)
    }
}
