//
//  RecordViewController.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2021/11/20.
//

import UIKit
import RealmSwift
import Toast

class RecordViewController: UIViewController {
    var editRecordBool = false //셀에서 진입시 true, 추가 버튼에서 진입시 false
    var selectDate = Date()
    var selectEmotionInt = 0
    let emotions = ["😐", "😸", "😾", "😿", "😓", "🙀", "🤑"]
    
    var existingSubject = ""
    var existingMoeny = ""
    var existingContent = ""
    
    let localRealm = try! Realm()
    
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
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(saveButtonClicked))
        }
        else{
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(checkButtonClicked))
            subjectTextField.isEnabled = false
            moneyTextField.isEnabled = false
            contentTextView.isEditable = false
            dateButton.isEnabled = false
            emotionButton.isEnabled = false
            
            subjectTextField.text = existingSubject
            moneyTextField.text = existingMoeny == "" ? " " : existingMoeny + "원"
            contentTextView.text = existingContent
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let dateString = DateFormatter().koreaDateFormatString(date: selectDate)
        dateButton.setTitle(dateString, for: .normal)
        
        emotionButton.setTitle("감정 표정은 \(emotions[selectEmotionInt])", for: .normal)
    }
    
    //우측 상단 확인버튼 클릭시
    @objc func checkButtonClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //우측 상단 완료버튼 클릭시
    @objc func saveButtonClicked(){
    
        //공백일 경우
        guard let subject = subjectTextField.text else{ return }
        if subject.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            self.view.makeToast("무엇을 소비했는지 써주세요!", duration: 3.0, position: .top)
            return
        }
        var content = contentTextView.text
        if content == "감정 소비한 이유를 적어보세요 :)"{
            content = ""
        }
        //Realm 저장
        let task = CostList(costSubject: subject, costMoney: moneyTextField.text, costContent: content, costDate: selectDate, costEmotion: selectEmotionInt)
                    
        try! self.localRealm.write {
            self.localRealm.add(task)
        }
        
        self.dismiss(animated: true, completion: nil)
        
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
