//
//  DatePickerViewController.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2021/11/22.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.layer.cornerRadius = 25
        popUpView.clipsToBounds = true
        
        //maximumDate 0으로 하여 미래는 못 가게 하기
        var components = DateComponents()
        components.day = 0
        let maxDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())
        datePicker.maximumDate = maxDate
        
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
    }
    
    @objc private func handleDatePicker(_ sender: UIDatePicker) {
        print(sender.date)
        
    }
    
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        
        self.dismiss(animated: true)
    }
    
    
}
