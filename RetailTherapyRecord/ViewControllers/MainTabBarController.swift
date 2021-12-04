//
//  MainTabBarController.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2021/11/20.
//

import UIKit
import JJFloatingActionButton //https://github.com/jjochen/JJFloatingActionButton

class MainTabBarController: UITabBarController {
    
    static let actionButton = JJFloatingActionButton() //플로팅 라이브러리
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegate = self
//        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
//        swipeRight.direction = .right
//        self.view.addGestureRecognizer(swipeRight)
//
//        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
//        swipeLeft.direction = .left
//        self.view.addGestureRecognizer(swipeLeft)


        addFloatingButton()
    }
    
    @objc func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
            
        if gesture.direction == .left {
            if (self.selectedIndex) < 1 { // 슬라이드할 탭바 갯수 지정 (전체 탭바 갯수 - 1)
                animateToTab(toIndex: self.selectedIndex+1)
            }
        } else if gesture.direction == .right {
            if (self.selectedIndex) > 0 {
                animateToTab(toIndex: self.selectedIndex-1)
            }
        }
    }



    func addFloatingButton(){
        //let actionButton = JJFloatingActionButton() //플로팅 라이브러리
        
        MainTabBarController.actionButton.addTarget(self, action: #selector(self.addButtonAction(sender:)), for: UIControl.Event.touchUpInside)
        MainTabBarController.actionButton.buttonColor = .primary //배경색
        MainTabBarController.actionButton.buttonImageColor = .white //이미지
        
        self.view.addSubview(MainTabBarController.actionButton)
        MainTabBarController.actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        //탭바 높이
        let tabBarheight = self.tabBar.frame.size.height
        //safe area 높이
        let window = UIApplication.shared.windows.first
        let bottomPadding = window!.safeAreaInsets.bottom
        //밑에 패딩
        let bottomConstant = tabBarheight/2 + bottomPadding
        //바닥에서 탭바 높이 만큼
        NSLayoutConstraint(item: MainTabBarController.actionButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -bottomConstant).isActive = true
        //x중앙배치
        NSLayoutConstraint(item: MainTabBarController.actionButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        
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


//스와이프시 탭 옮기기
extension MainTabBarController: UITabBarControllerDelegate  {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let tabViewControllers = tabBarController.viewControllers, let toIndex = tabViewControllers.firstIndex(of: viewController) else {
            return false
        }
        animateToTab(toIndex: toIndex)
        return true
    }
    
    func animateToTab(toIndex: Int) {
        guard let tabViewControllers = viewControllers,
            let selectedVC = selectedViewController else { return }
        
        guard let fromView = selectedVC.view,
            let toView = tabViewControllers[toIndex].view,
            let fromIndex = tabViewControllers.firstIndex(of: selectedVC),
            fromIndex != toIndex else { return }
        
        
        // Add the toView to the tab bar view
        fromView.superview?.addSubview(toView)
        
        // Position toView off screen (to the left/right of fromView)
        let screenWidth = UIScreen.main.bounds.size.width
        let scrollRight = toIndex > fromIndex
        let offset = (scrollRight ? screenWidth : -screenWidth)
        toView.center = CGPoint(x: fromView.center.x + offset, y: toView.center.y)
        
        // Disable interaction during animation
        view.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
            // Slide the views by -offset
            fromView.center = CGPoint(x: fromView.center.x - offset, y: fromView.center.y)
            toView.center = CGPoint(x: toView.center.x - offset, y: toView.center.y)
            
            }, completion: { finished in
                // Remove the old view from the tabbar view.
                fromView.removeFromSuperview()
                self.selectedIndex = toIndex
                self.view.isUserInteractionEnabled = true
        })
    }
}


