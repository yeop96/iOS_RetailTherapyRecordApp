//
//  EmotionPickerViewController.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2021/11/22.
//

import UIKit

class EmotionPickerViewController: UIViewController {
    
    let emotions = ["😐", "😸", "😾", "😿", "😓", "🙀", "🤑"]
    var selectEmotionInt = 0
    var saveActionHandler: (() -> Void)?

    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.layer.cornerRadius = 25
        popUpView.clipsToBounds = true
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    

    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        saveActionHandler?()
        self.dismiss(animated: true)
    }
    
}

extension EmotionPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    // 피커 뷰의 컴포넌트 수 설정
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // 피커 뷰의 높이 설정
//    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return 80
//
//    }

    // 피커 뷰의 개수 설정
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return emotions.count
       
    }

    // 피커 뷰의 각 Row의 타이틀 설정
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return emotions[row]
       
    }

    // 피커 뷰가 선택되었을 때 실행
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //selectEmotion = emotions[row]
        selectEmotionInt = row
       
    }
    
    
}
