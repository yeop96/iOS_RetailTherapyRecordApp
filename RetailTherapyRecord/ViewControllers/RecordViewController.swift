//
//  RecordViewController.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2021/11/20.
//

import UIKit

class RecordViewController: UIViewController {
    var editRecordBool = false //셀에서 진입시 true, 추가 버튼에서 진입시 false
    var selectDate = Date()
    var selectEmotion = "😶"
    var selectEmotionInt = 0
    
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var emotionButton: UIButton!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var moneyTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextView.delegate = self
        
        title = editRecordBool ? "감정 소비 내역" : "감정 소비 기록"
        
        
        if !editRecordBool{
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissAction))
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(saveButtonClicked))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let dateString = DateFormatter().koreaDateFormatString(date: selectDate)
        dateButton.setTitle(dateString, for: .normal)
        
        emotionButton.setTitle("감정 표정은 \(selectEmotion)", for: .normal)
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
    
    // 날짜 클릭시
    @IBAction func dateButtonClicked(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Record", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DatePickerViewController") as! DatePickerViewController
        
        vc.saveActionHandler = {
            
            self.selectDate = vc.selectDate
            self.viewWillAppear(true)
        }
        
        vc.selectDate = selectDate
        
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
        
    }
    
    // 감정 이모지 클릭시
    @IBAction func emotionButtonClicked(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Record", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EmotionPickerViewController") as! EmotionPickerViewController
        
        vc.saveActionHandler = {
            self.selectEmotion = vc.selectEmotion
            self.selectEmotionInt = vc.selectEmotionInt
            self.viewWillAppear(true)
        }
        
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
}


// MARK: - UITextViewDelegate
extension RecordViewController: UITextViewDelegate{
    //편집이 시작될 때
    func textViewDidBeginEditing(_ textView: UITextView) {
        textViewSetupView()
    }
    //편집이 종료될 때
    func textViewDidEndEditing(_ textView: UITextView) {
        if contentTextView.text == ""{
            textViewSetupView()
        }
    }
    
    
    func textViewSetupView(){
        if contentTextView.text == "감정 소비한 이유를 적어보세요 :)"{
            contentTextView.text = ""
            contentTextView.textColor = .black
        }
        else if contentTextView.text == ""{
            contentTextView.text = "감정 소비한 이유를 적어보세요 :)"
            contentTextView.textColor = .placeholderText
        }
    }
}
