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
    var imageFileName = ["expressionless.png", "smile.png", "angry.png", "cry.png", "sad.png", "stressed.png", "rich.png"] // 이미지의 파일명을 저장할 배열
        
    
    var existingSubject = ""
    var existingMoeny = ""
    var existingContent = ""
    
    let localRealm = try! Realm()
    var taskUpdateRow: CostList!
    
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var emotionButton: UIButton!
    @IBOutlet weak var emotionImageView: UIImageView!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var moneyTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextView.delegate = self
        subjectTextField.delegate = self
        moneyTextField.delegate = self
        
        title = editRecordBool ? "감정 소비 내역" : "감정 소비 기록"
        
        
        
        if !editRecordBool{
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissAction))
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(saveButtonClicked))
            
            //이미지 버튼 클릭 가능하게
            let emotionImageButton = UITapGestureRecognizer(target: self, action: #selector(emotionImageButtonClicked))
            emotionImageView.isUserInteractionEnabled = true
            emotionImageView.addGestureRecognizer(emotionImageButton)
            
            emotionButton.setTitle("표정 선택", for: .normal)
            subjectTextField.becomeFirstResponder()

        }
        else{
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "편집", style: .plain, target: self, action: #selector(checkButtonClicked))
            subjectTextField.isEnabled = false
            moneyTextField.isEnabled = false
            contentTextView.isEditable = false
            dateButton.isEnabled = false
            emotionButton.isEnabled = false
            
            
            subjectTextField.text = existingSubject
            moneyTextField.text = existingMoeny
            contentTextView.text = existingContent
            
            emotionButton.setTitle("표정", for: .normal)
            
            
            self.tabBarController?.tabBar.isHidden = true
            MainTabBarController.actionButton.isHidden = true
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let dateString = DateFormatter().koreaDateFormatString(date: selectDate)
        dateButton.setTitle(dateString, for: .normal)
        emotionImageView.image = UIImage(named: imageFileName[selectEmotionInt])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        MainTabBarController.actionButton.isHidden = false
    }
    
    
    //편집 버튼 클릭시
    @objc func checkButtonClicked(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(editSaveButtonClicked))
        subjectTextField.isEnabled = true
        moneyTextField.isEnabled = true
        contentTextView.isEditable = true
        dateButton.isEnabled = true
        emotionButton.isEnabled = true
    }
    
    //편집 저장 클릭시
    @objc func editSaveButtonClicked(){
    
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
        
        //소비 금액이 숫자가 아닐 경우
        if !moneyTextField.text!.isEmpty{
            let pattern = "^[0-9]{0,}$"
            let regex = try? NSRegularExpression(pattern: pattern)
            guard let _ = regex?.firstMatch(in: moneyTextField.text!, options: [], range: NSRange(location: 0, length: moneyTextField.text!.count)) else{
                self.view.makeToast("소비 금액은 숫자만 써주세요 :)", duration: 3.0, position: .top)
                return
            }
        }
        
        //Realm 데이터 수정
        let taskUpdate = taskUpdateRow!
        try! self.localRealm.write {
            taskUpdate.costSubject = subject
            taskUpdate.costMoney = moneyTextField.text
            taskUpdate.costContent = content
            taskUpdate.costDate = selectDate
            taskUpdate.costDateString = DateFormatter().connectDateFormatString(date: selectDate)
            taskUpdate.costEmotion = selectEmotionInt
        }
        
        
        
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
        //소비 금액이 숫자가 아닐 경우
        if !moneyTextField.text!.isEmpty{
            let pattern = "^[0-9]{0,}$"
            let regex = try? NSRegularExpression(pattern: pattern)
            guard let _ = regex?.firstMatch(in: moneyTextField.text!, options: [], range: NSRange(location: 0, length: moneyTextField.text!.count)) else{
                self.view.makeToast("소비 금액은 숫자만 써주세요 :)", duration: 3.0, position: .top)
                return
            }
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
    
    @objc func emotionImageButtonClicked(sender: UITapGestureRecognizer) {
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

extension RecordViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 20 // 숫자제한
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
            contentTextView.textColor = .label
        }
        else if contentTextView.text == ""{
            contentTextView.text = "감정 소비한 이유를 적어보세요 :)"
            contentTextView.textColor = .placeholderText
        }
    }
}
