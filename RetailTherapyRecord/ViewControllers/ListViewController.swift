//
//  ListViewController.swift
//  RetailTherapyRecord
//
//  Created by yeop on 2021/11/20.
//

import UIKit
import RealmSwift

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}



extension ListViewController: UITableViewDelegate, UITableViewDataSource{
    
    //섹션의 수: numberOfSections (default가 1이라서)
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //섹션 타이틀: titleForHeaderInSection
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "섹션 타이틀"
    }
    
    //셀의 갯수: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20
    }
    
    //셀의 디자인 및 데이터 처리: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") as? ListTableViewCell else{
            return UITableViewCell()
        }
        
        cell.emotionImageView.image = UIImage(systemName: "plus")
        cell.costSubjectLabel.text = "?!"
        cell.costMoneyLabel.text = "?!"
        cell.costContentLabel.text = "?!"
        
        return cell
    }
    
    //셀의 높이: heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    //헤더 높이: heightForHeaderInSection
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 37
    }
    
    //셀 선택 didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("셀선택")
    }
    //셀 스와이프 ON commit
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            print("삭제")
            tableView.reloadData()
        }
    }
    
}


// 감정 소비 기록 셀 클래스
class ListTableViewCell: UITableViewCell{
    @IBOutlet weak var emotionImageView: UIImageView!
    @IBOutlet weak var costSubjectLabel: UILabel!
    @IBOutlet weak var costMoneyLabel: UILabel!
    @IBOutlet weak var costContentLabel: UILabel!
    
}

