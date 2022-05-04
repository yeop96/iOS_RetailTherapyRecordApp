//
//  DatePickerViewController.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2021/11/22.
//

import UIKit

final class DatePickerViewController: BaseViewController {
    
    var saveActionHandler: (() -> Void)?
    var selectDate = Date()
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        popUpView.layer.cornerRadius = 25
        popUpView.clipsToBounds = true
        
        //데이트 피커 과거,미래 제한
        var components = DateComponents()
        components.day = 0
        let maxDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())
        components.year = -100
        let minDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())
        
        datePicker.maximumDate = maxDate
        datePicker.minimumDate = minDate
        datePicker.date = selectDate
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
        
        datePicker.maximumDate = maxDate
        datePicker.minimumDate = minDate
    }
    
    @objc private func handleDatePicker(_ sender: UIDatePicker) {
        selectDate = sender.date
    }
    
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        saveActionHandler?()
        self.dismiss(animated: true)
    }
    
    
}
