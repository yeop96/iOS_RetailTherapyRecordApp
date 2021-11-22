//
//  MainTabBarController.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2021/11/20.
//

import UIKit
import JJFloatingActionButton //https://github.com/jjochen/JJFloatingActionButton

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addFloatingButton()
    }
    
    func addFloatingButton(){
        let actionButton = JJFloatingActionButton() //플로팅 라이브러리
        
        actionButton.addTarget(self, action: #selector(self.addButtonAction(sender:)), for: UIControl.Event.touchUpInside)
        actionButton.buttonColor = .lightGray //배경색
        actionButton.buttonImageColor = .white //이미지
        
        self.view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        //탭바 높이
        let tabBarheight = self.tabBar.frame.size.height
        //바닥에서 탭바 높이 만큼
        NSLayoutConstraint(item: actionButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -tabBarheight).isActive = true
        //x중앙배치
        NSLayoutConstraint(item: actionButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        
        self.view.layoutIfNeeded() //즉시 적용 동기
    }
    
    //버튼 액션 함수
    @objc func addButtonAction(sender: UIButton){
        self.selectedIndex = 777 //탭바에 없는 인덱스로 줌
        
        //작성뷰로 modal
        let storyboard = UIStoryboard(name: "Record", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RecordViewController") as! RecordViewController
        vc.editRecordBool = false
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }

}
