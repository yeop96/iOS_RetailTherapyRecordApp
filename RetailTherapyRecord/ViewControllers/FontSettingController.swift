//
//  FontSettingController.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2022/03/31.
//


import UIKit

final class FontSettingViewController: UIViewController{
    
    @IBOutlet weak var recordView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet var radioButtons: [UIButton]!
    var indexOfOneAndOnlySelectedBtn = UserData.customUserFont
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "나의 글씨체"
        self.navigationController?.navigationBar.titleTextAttributes = [.font: UIFont().customFont21]
        
        recordView.layer.borderWidth = 1
        recordView.layer.cornerRadius = 8
        recordView.layer.borderColor = UIColor.primary.cgColor
        
        titleLabel.font = UIFont().customFont18
        moneyLabel.font = UIFont().customFont17
        descriptionLabel.font = UIFont().customFont17
        
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
        titleLabel.font = UIFont().customFont18
        moneyLabel.font = UIFont().customFont17
        descriptionLabel.font = UIFont().customFont17
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
}
