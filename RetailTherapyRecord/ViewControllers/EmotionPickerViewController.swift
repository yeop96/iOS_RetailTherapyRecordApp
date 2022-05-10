//
//  EmotionPickerViewController.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2021/11/22.
//

import UIKit

final class EmotionPickerViewController: BaseViewController {
    
    let MAX_ARRAY_NUM = 7 // 이미지의 파일명을 저장할 배열의 최대 크기를 지정
    let PICKER_VIEW_COLUMN = 1 // 피커 뷰의 열의 갯수 지정
    let PICKER_VIEW_HEIGHT: CGFloat = 64 // 피커 뷰의 높이를 지정할 상수
    var imageArray = [UIImage?]()
    var selectEmotionInt = 0
    var saveActionHandler: (() -> Void)?
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        popUpView.layer.cornerRadius = 25
        popUpView.clipsToBounds = true
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        for i in 0 ..< MAX_ARRAY_NUM {
            // 각 파일에 해당하는 이미지를 생성
            let image = Expression(rawValue: i)?.expressionEmoji()
            // 생성된 이미지를 imageArray에 추가
            imageArray.append(image)
        }
    }
    
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        saveActionHandler?()
        self.dismiss(animated: true)
    }
    
}


// MARK: - UIPickerViewDelegate
extension EmotionPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    // 피커 뷰의 컴포넌트 수 설정
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return PICKER_VIEW_COLUMN
    }
    
    // 피커 뷰의 높이 설정
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return PICKER_VIEW_HEIGHT
    }
    
    // 피커 뷰의 개수 설정
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Expression.allCases.count
    }
    
    
    // 피커 뷰의 각 Row의 view 설정
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView{
        let imageView = UIImageView(image: imageArray[row])
        imageView.frame = CGRect(x: 0, y: 0, width: 64, height: 64) // 이미지 뷰의 프레임 크기 설정
        
        return imageView
    }
    
    // 피커 뷰가 선택되었을 때 실행
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectEmotionInt = row
    }
    
}
