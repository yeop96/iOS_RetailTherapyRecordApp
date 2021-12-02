//
//  SettingViewController.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2021/12/02.
//

import UIKit
import SafariServices
import MessageUI

class SettingViewController: UIViewController, SFSafariViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let settings = [["오픈소스 라이선스", ">"], ["문의하기",">"], ["앱 버전","1.0.0"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        title = "서비스 정보"
        
        
        self.tabBarController?.tabBar.isHidden = true
        MainTabBarController.actionButton.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        MainTabBarController.actionButton.isHidden = false
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingListTableViewCell") as? SettingListTableViewCell else{
            return UITableViewCell()
        }
        
        cell.titleLabel.text = settings[indexPath.row][0]
        cell.rightLabel.text = settings[indexPath.row][1]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            guard let appleUrl = URL(string: "https://organic-shingle-94f.notion.site/7ead3acad79c4a63a414ca9bc7711443")   else { return }

            let safariViewController = SFSafariViewController(url: appleUrl)
            safariViewController.delegate = self
            safariViewController.modalPresentationStyle = .automatic
            self.present(safariViewController, animated: true, completion: nil)
            
        }
        else if indexPath.row == 1{
            if MFMailComposeViewController.canSendMail() {
                        
                let compseVC = MFMailComposeViewController()
                compseVC.mailComposeDelegate = self
                compseVC.setToRecipients(["ekdh787@gmail.com"])
                compseVC.setSubject("[감정 소비]")
                //compseVC.setMessageBody("Message Content", isHTML: false)
                self.present(compseVC, animated: true, completion: nil)
                
            }
            else {
                self.showSendMailErrorAlert()
            }
        }
        
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "메일을 전송 실패", message: "아이폰 이메일 설정을 확인하고 다시 시도해주세요.", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default) {
            (action) in
            print("확인")
        }
        sendMailErrorAlert.addAction(confirmAction)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }

}


class SettingListTableViewCell: UITableViewCell{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
}
