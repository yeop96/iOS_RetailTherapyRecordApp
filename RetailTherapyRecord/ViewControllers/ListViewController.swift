//
//  ListViewController.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2021/11/20.
//

import UIKit
import RealmSwift

class ListViewController: UIViewController {
    var searchController:  UISearchController!
    let localRealm = try! Realm()
    var tasks: Results<CostList>!
    var dateSet = Set<String>()
    var dateArray = Array<String>()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchController = searchBarSetting()
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        //tasks = localRealm.objects(CostList.self).sorted(byKeyPath: "costDate", ascending: false) // 최근 등록일 순
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tasks = localRealm.objects(CostList.self).sorted(byKeyPath: "costDate", ascending: false) // 최근 등록일 순
        dateSet = Set<String>()
        tasks.forEach{
            dateSet.insert(DateFormatter().connectDateFormatString(date: $0.costDate))
        }
        dateArray = Array(dateSet.sorted(by: >))
        tableView.reloadData()
    }
    
    
    func searchBarSetting() -> UISearchController{
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색"
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        //searchController.searchBar.tintColor = .systemBackground
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false // 스크롤 할 때 서치부분은 남겨두기
        
        return searchController
    }
}


extension ListViewController: UISearchBarDelegate, UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        
        tableView.reloadData()
    }
    
    //검색 버튼(키보드 리턴키)을 눌렀을 때 실행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    //취소 버튼 눌렀을 때 실행
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    //서치바에 커서 깜빡이기 시작할 때
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        updateSearchResults(for: searchController)
    }
    
}


extension ListViewController: UITableViewDelegate, UITableViewDataSource{
    
    //섹션의 수: numberOfSections (default가 1이라서)
    func numberOfSections(in tableView: UITableView) -> Int {
        return dateArray.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    //섹션 타이틀: titleForHeaderInSection
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dateArray[section]
    }
    
    //셀의 갯수: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let taskFiltered = tasks.filter("costDateString == '\(dateArray[section])'")
        return taskFiltered.count
    }
    
    //셀의 디자인 및 데이터 처리: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") as? ListTableViewCell else{
            return UITableViewCell()
        }
        
        //섹션에 맞는 날짜만
        let taskFiltered = tasks.filter("costDateString == '\(dateArray[indexPath.section])'")
        let row = taskFiltered[indexPath.row]
        
        if let emotion = Expression(rawValue: row.costEmotion) {
            cell.emotionImageView.image = emotion.expressionEmoji()
        }
        cell.costSubjectLabel.text = row.costSubject
        cell.costMoneyLabel.text = row.costMoney == "" ? "" : row.costMoney! + "원"
        cell.costContentLabel.text = row.costContent
        
        return cell
    }
    
    //셀의 높이: heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90
    }
    //헤더 높이: heightForHeaderInSection
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 37
    }
    
    //셀 선택 didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskFiltered = tasks.filter("costDateString == '\(dateArray[indexPath.section])'")
        let row = taskFiltered[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Record", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RecordViewController") as! RecordViewController
        vc.editRecordBool = true
        vc.selectDate = row.costDate
        vc.selectEmotionInt = row.costEmotion
        vc.existingSubject = row.costSubject
        vc.existingMoeny = row.costMoney ?? ""
        vc.existingContent = row.costContent ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //셀 스와이프 ON commit
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //삭제 스와이프
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let taskFiltered = tasks.filter("costDateString == '\(dateArray[indexPath.section])'")
        let row = taskFiltered[indexPath.row]
        
        let alert = UIAlertController(title: row.costSubject, message: "기록을 삭제해도 되나요?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "예", style: .default){ (action) in
            
            try! self.localRealm.write{
                self.localRealm.delete(row)
                
                self.viewWillAppear(true)
            }
            return
        }
        let noAction = UIAlertAction(title: "아니오", style: .cancel){ (action) in
            return
        }
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
    }
    
}


// 감정 소비 기록 셀 클래스
class ListTableViewCell: UITableViewCell{
    @IBOutlet weak var emotionImageView: UIImageView!
    @IBOutlet weak var costSubjectLabel: UILabel!
    @IBOutlet weak var costMoneyLabel: UILabel!
    @IBOutlet weak var costContentLabel: UILabel!
    
}

