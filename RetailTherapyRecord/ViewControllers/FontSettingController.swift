//
//  FontSettingController.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2022/03/31.
//


import UIKit
import NotificationBannerSwift

final class FontSettingViewController: BaseViewController{
    
    @IBOutlet weak var recordView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var radioButtons: [UIButton]!
    var indexOfOneAndOnlySelectedBtn = UserData.customUserFont
    var clickCount = 0
    
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
        
        clickCount = 0
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(recordViewClicked(sender:)))
        recordView.addGestureRecognizer(tapGesture)
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
    
    
    @objc func recordViewClicked(sender: UITapGestureRecognizer){
        let leftView = UIImageView(image: UIImage(named: "wasted")!)
        if clickCount < 5{
            let banner = NotificationBanner(title: "글씨체 확인 예시입니다!", leftView: leftView, style: .success, colors: CustomBannerColors())
            
            banner.titleLabel?.textColor = .label
            banner.titleLabel?.font = UIFont().customFont_Content
            banner.duration = 0.2
            banner.show()
            
            clickCount += 1
        } else{
            return
        }
    }
    
    
}
