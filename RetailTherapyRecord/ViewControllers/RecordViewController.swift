//
//  RecordViewController.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2021/11/20.
//

import UIKit

class RecordViewController: UIViewController {
    var editRecordBool = false //셀에서 진입시 true, 추가 버튼에서 진입시 false
    
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var emotionButton: UIButton!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var moneyTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = editRecordBool ? "감정 소비 내역" : "감정 소비 기록"
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
    
    
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        
        //키보드 내리기
        view.endEditing(true)

    }
    
    @IBAction func dateButtonClicked(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Record", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DatePickerViewController") as! DatePickerViewController
        
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func emotionButtonClicked(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Record", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EmotionPickerViewController") as! EmotionPickerViewController
        
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
}
