//
//  StudyListViewController.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Then

class StudyListViewController: UIViewController {
    let tableView = UITableView()
    override func viewDidLoad() {
        attribute()
        layout()
    }
    
    func attribute() {
        tableView.register(StudyCell.self, forCellReuseIdentifier: StudyCell.cellId)
        tableView.rowHeight = 90
    }
    
    func layout() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}

extension StudyListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StudyCell.cellId, for: indexPath) as! StudyCell
        cell.title1.text = "스니커즈 어플 만드실분"
        cell.subTitle.text = "안녕하세요 많은 참여 부탁드립니다."
        cell.location.text = "강남구"
        cell.date.text = "4/23 |"
        cell.managerImage.image = #imageLiteral(resourceName: "Image-1")
        cell.mainImage.image = #imageLiteral(resourceName: "jpark")
        
        return cell
    }
}
