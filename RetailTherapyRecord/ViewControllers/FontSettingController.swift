//
//  FontSettingController.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2022/03/31.
//


import UIKit

final class FontSettingViewController: UIViewController{
    @IBOutlet var radioButtons: [UIButton]!
    var indexOfOneAndOnlySelectedBtn = UserData.customUserFont
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "나의 글씨체"
        self.navigationController?.navigationBar.titleTextAttributes = [.font: UIFont().customFont21]
        
        radioButtons.forEach{
            $0.setImage(UIImage(systemName: "circle"), for: .normal)
            $0.setImage(UIImage(systemName: "heart.circle"), for: .selected)
        }
        radioButtons[indexOfOneAndOnlySelectedBtn].isSelected = true
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        for unselectIndex in radioButtons.indices {
            radioButtons[unselectIndex].isSelected = false
        }
        sender.isSelected = true
        indexOfOneAndOnlySelectedBtn = radioButtons.firstIndex(of: sender)!
        
        UserData.customUserFont = indexOfOneAndOnlySelectedBtn
        
        if #available(iOS 15, *) {
            self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.font : UIFont().customFont21]
            self.navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [.font : UIFont().customFont21]
        } else{
            self.navigationController?.navigationBar.titleTextAttributes = [.font: UIFont().customFont21]
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
}
