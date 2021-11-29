//
//  CalendarViewController.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2021/11/20.
//

import UIKit
import FSCalendar
import RealmSwift

class CalendarViewController: UIViewController {

    let localRealm = try! Realm()
    var tasks: Results<CostList>!
    var dateSet = Set<String>()
    var dateArray = Array<String>()
    var events = Array<Date?>()
    
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var yearCostLabel: UILabel!
    @IBOutlet weak var unCostDayLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView.delegate = self
        calendarView.dataSource = self
        
        calendarView.appearance.eventDefaultColor = .brown
        calendarView.appearance.eventSelectionColor = .brown
        calendarView.allowsSelection = false
        calendarView.today = nil
        
        //calendarView.appearance.borderRadius = 0
        
        calendarView.headerHeight = 50
        calendarView.appearance.headerDateFormat = "YYYY년 M월"
        calendarView.appearance.headerTitleColor = .black
        calendarView.appearance.headerTitleFont = UIFont.systemFont(ofSize: 24)

        calendarView.appearance.weekdayTextColor = .black

        calendarView.locale = Locale(identifier: "ko_KR")


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tasks = localRealm.objects(CostList.self).sorted(byKeyPath: "costDate", ascending: false) // 최근 등록일 순
        
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
        
        if !tasks.isEmpty{
            let day = DateFormatter().DateFormatInt(date: Date()) - DateFormatter().DateFormatInt(date: tasks[0].costDate)
            unCostDayLabel.text = "\(String(day))일"
        } else{
            unCostDayLabel.text = "아직 없음"
        }
        
        calendarView.reloadData()
    }


}


extension CalendarViewController : FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    //밑에 동그란 이벤트 표시
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//        if self.events.contains(date){
//            return 1
//        } else {
//            return 0
//        }
        return 0
    }
    
    //글자색
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        return nil
    }
    
    //셀 색
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        if self.events.contains(date) {
            return .brown
        } else {
            return nil
        }
    }
}

