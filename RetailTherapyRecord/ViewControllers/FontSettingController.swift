//
//  FontSettingController.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2022/03/31.
//


import UIKit

final class FontSettingViewController: BaseViewController{
    
    @IBOutlet weak var recordView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var radioButtons: [UIButton]!
    var indexOfOneAndOnlySelectedBtn = UserData.customUserFont
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        title = "나의 글씨체"
        recordView.layer.borderWidth = 1
        recordView.layer.cornerRadius = 8
        recordView.layer.borderColor = UIColor.primary.cgColor
        
        titleLabel.font = UIFont().customFont_Title
        moneyLabel.font = UIFont().customFont_Content
        descriptionLabel.font = UIFont().customFont_Content
        
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
        
        navigationBarFontSet()
        titleLabel.font = UIFont().customFont_Title
        moneyLabel.font = UIFont().customFont_Content
        descriptionLabel.font = UIFont().customFont_Content
    }
    
}
