//
//  SettingViewController.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2021/12/02.
//

import UIKit
import SafariServices
import MessageUI
import NotificationBannerSwift
import Zip
//import MobileCoreServices

final class SettingViewController: BaseViewController, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var clickCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        clickCount = 0
    }
    
    override func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        
        title = "서비스 정보"
        
        self.tableView.tableFooterView = UIView()
        tabBarHiddenSet(hidden: true)
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingString.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingListTableViewCell") as? SettingListTableViewCell else{
            return UITableViewCell()
        }
        let row = indexPath.row
        
        cell.titleLabel.font = UIFont().customFont_Content
        cell.rightLabel.font = UIFont().customFont_Content
        
        cell.titleLabel.text = SettingString(rawValue: row)?.settingTitle()
        cell.rightLabel.text = row == SettingString.appVersion.rawValue ? appVersionGet() : ">"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        //오픈소스 라이선스
        if row == SettingString.openSourceLicense.rawValue{
            guard let appleUrl = URL(string: "https://organic-shingle-94f.notion.site/7ead3acad79c4a63a414ca9bc7711443")   else { return }
            let safariViewController = SFSafariViewController(url: appleUrl)
            safariViewController.delegate = self
            safariViewController.modalPresentationStyle = .automatic
            self.present(safariViewController, animated: true, completion: nil)
            
        }
        //문의하기
        else if row == SettingString.contactUs.rawValue{
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
        //앱 이야기
        else if row == SettingString.appStory.rawValue{
            guard let appleUrl = URL(string: "https://organic-shingle-94f.notion.site/d2081d949d094b93b325d730ec946033")   else { return }
            let safariViewController = SFSafariViewController(url: appleUrl)
            safariViewController.delegate = self
            safariViewController.modalPresentationStyle = .automatic
            self.present(safariViewController, animated: true, completion: nil)
        }
        //나의 글씨체
        else if row == SettingString.myFont.rawValue{
            let storyboard = UIStoryboard(name: "FontSetting", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "FontSettingViewController") as! FontSettingViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        //데이터 백업
        else if row == SettingString.dataBackup.rawValue{
            
        }
        //데이터 복구
        else if row == SettingString.dataRestore.rawValue{
            
        }
        //앱스토어 리뷰
        else if row == SettingString.appStoreReview.rawValue{
            let appAppleID = Bundle.main.appAppleID
            requestReviewmenually(id: appAppleID)
        }
        //앱 버전
        else if row == SettingString.appVersion.rawValue{
            let leftView = UIImageView(image: UIImage(named: "wasted")!)
            if clickCount > 10{
                return
            } else if clickCount > 5{
                let banner = NotificationBanner(title: "이제 그만..!", leftView: leftView, style: .warning, colors: CustomBannerColors())
                
                banner.titleLabel?.textColor = .label
                banner.titleLabel?.font = UIFont().customFont_Content
                banner.duration = 0.1
                banner.show()
            }
            else{
                let banner = NotificationBanner(title: "반가워엽 :)", leftView: leftView, style: .success, colors: CustomBannerColors())
                
                banner.titleLabel?.textColor = .label
                banner.titleLabel?.font = UIFont().customFont_Content
                banner.duration = 0.5
                banner.show()
            }
            clickCount += 1
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
    
    func requestReviewmenually(id: String) { //app store connect의 앱정보에서 apple id를 확인한다
        guard let writeReviewURL = URL(string: "https://apps.apple.com/app/id\(id)?action=write-review")
        else { return }
        UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
    }
    
    func appVersionGet() -> String{
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String
        else { return "" }
        return version
    }
}

extension SettingViewController: UIDocumentPickerDelegate{
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("취소됐을때")
    }
    
    //도큐먼트 폴더 위치
    func documentDirectoryPath() -> String?{
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first{
            return directoryPath
        }
        else{
            return nil
        }
    }
    
    //공유 화면
    func presentActivityViewController(){
        //압축 파일 경로 가져오기
        let fileName = (documentDirectoryPath()! as NSString).appendingPathComponent("EmotionalConsumption_App_data.zip")
        let fileURL = URL(fileURLWithPath: fileName)
        let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities: [])
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        //선택한 파일에 대한 경로를 가져와야함
        guard let selectedFileURL = urls.first else { return }
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sandboxFileURL = directory.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        //압축 해제
        if FileManager.default.fileExists(atPath: sandboxFileURL.path){
            //기존에 복구하고자 하는 zip파일을 도큐먼트에 가지고 있을 경우, 도큐먼트에 위치한 zip파일을 압축 해제 하면 됨
            do{
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("EmotionalConsumption_App_data.zip")
                
                try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    print(progress)
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile : \(unzippedFile) ")
                    
                    let alert = UIAlertController(title: "복구 완료", message: "앱을 재실행 해주세요", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "확인", style: .default){ (action) in
                        exit(0)
                    }
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                })
            }
            catch{
                print("error")
            }
            
        }
        else{
            //파일 앱의 zip -> 도큐먼트 폴더에 복사
            do{
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("EmotionalConsumption_App_data.zip")
                
                try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    print(progress)
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile : \(unzippedFile) ")
                    
                    let alert = UIAlertController(title: "복구 완료", message: "앱을 재실행 해주세요", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "확인", style: .default){ (action) in
                        exit(0)
                    }
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                })
            }
            catch{
                print("error")
            }
        }
        
    }
    
}

class SettingListTableViewCell: UITableViewCell{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

