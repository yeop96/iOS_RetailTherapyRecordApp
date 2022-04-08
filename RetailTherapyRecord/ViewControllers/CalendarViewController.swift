//
//  CalendarViewController.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2021/11/20.
//

import UIKit
import FSCalendar
import RealmSwift

final class CalendarViewController: BaseViewController {

    let localRealm = try! Realm()
    var tasks: Results<CostList>!
    var dateSet = Set<String>()
    var dateArray = Array<String>()
    var events = Array<Date?>()
    
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var yearCostLabel: UILabel!
    @IBOutlet weak var unCostDayLabel: UILabel!
    @IBOutlet weak var calendarExplainLabel: UILabel!
    @IBOutlet weak var circleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView.delegate = self
        calendarView.dataSource = self
        
        yearCostLabel.font = UIFont().customFont_Content
        unCostDayLabel.font = UIFont().customFont_Content
        calendarExplainLabel.font = UIFont().customFont_Content
        
        calendarView.appearance.eventDefaultColor = .primary
        calendarView.appearance.eventSelectionColor = .primary
        calendarView.allowsSelection = false
        calendarView.today = nil
        //calendarView.appearance.todayColor
        //calendarView.appearance.titleTodayColor
        //calendarView.appearance.borderRadius = 0
        self.navigationItem.title = "흔적"
        navigationBarFontSet()
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(settingButtonClicked))
        
        calendarView.headerHeight = 50
        calendarView.appearance.headerDateFormat = "YYYY년 M월"
        calendarView.appearance.headerTitleFont = UIFont().customFont_Big
        calendarView.appearance.headerTitleColor = .primary

        calendarView.appearance.weekdayTextColor = .label
        calendarView.appearance.weekdayFont = UIFont().customFont_Content
        
        
        calendarView.appearance.titleWeekendColor = .strawberryMilk
        calendarView.appearance.titleDefaultColor = .label
        calendarView.appearance.titleFont = UIFont().customFont_Content
        calendarView.appearance.subtitleFont = UIFont().customFont_Header
        
        

        calendarView.locale = Locale(identifier: "ko_KR")
        
        circleView.backgroundColor = .primary
        circleView.layer.cornerRadius = circleView.frame.width / 2
        circleView.alpha = 0.8
        calendarExplainLabel.textColor = .placeholderText

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tasks = localRealm.objects(CostList.self).sorted(byKeyPath: "costDate", ascending: false) // 최근 등록일 순
        
        self.tabBarController?.tabBar.isHidden = false
        MainTabBarController.actionButton.isHidden = false
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
        
        events = Array<Date>()
        var cost = 0
        
        tasks.forEach{
            events +=  [formatter.date(from: DateFormatter().connectDateFormatString(date: $0.costDate))]
            
            guard let money = $0.costMoney else { return }
            cost += Int(money) ?? 0
        }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let costs = numberFormatter.string(for: cost)!
        yearCostLabel.text = costs + "원"
        
        //감정 소비 안한지 며칠인지 계산
        if tasks.isEmpty{
            unCostDayLabel.text = "아직 없음"
        } else{
            let distanceDay = Calendar.current.dateComponents([.day], from: Date(), to: tasks[0].costDate).day
            unCostDayLabel.text = "\(String(-distanceDay!))일"
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(settingButtonClicked))
        
        
        calendarView.reloadData()
    }


    
    //세팅 버튼 클릭시
    @objc func settingButtonClicked(){
        let storyboard = UIStoryboard(name: "Setting", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension CalendarViewController : FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    //밑에 동그란 이벤트 표시
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 0
    }
    
    //글자색
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        if self.events.contains(date) {
            return .secondary
        } else {
            return nil
        }
    }
    
    //셀 색
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        if self.events.contains(date) {
            return .primary
        } else {
            return nil
        }
    }
    
    // 날짜 밑에 글씨
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
            
        switch formatter.string(from: date) {
            case formatter.string(from: Date()):
                return "오늘"
            case "2022-12-25":
                return "크리스마스"
            default:
                return nil
        }
    }
}

