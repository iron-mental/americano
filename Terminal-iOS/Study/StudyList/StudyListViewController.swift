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
    
    let studyList = [
        Study(title: "스니커즈 어플 만드실분", subTitle: "안녕하세요 많은 참여 부탁드립니다.", location: "강남구", date: "09/21 |", managerImage: #imageLiteral(resourceName: "Image-1"), mainImage: #imageLiteral(resourceName: "Image")),
        Study(title: "스니커즈 어플 만드실분", subTitle: "안녕하세요 많은 참여 부탁드립니다.", location: "강남구", date: "09/21 |", managerImage: #imageLiteral(resourceName: "Image-1"), mainImage: #imageLiteral(resourceName: "Image")),
        Study(title: "스니커즈 어플 만드실분", subTitle: "안녕하세요 많은 참여 부탁드립니다.", location: "강남구", date: "09/21 |", managerImage: #imageLiteral(resourceName: "Image-1"), mainImage: #imageLiteral(resourceName: "Image")),
        Study(title: "스니커즈 어플 만드실분", subTitle: "안녕하세요 많은 참여 부탁드립니다.", location: "강남구", date: "09/21 |", managerImage: #imageLiteral(resourceName: "Image-1"), mainImage: #imageLiteral(resourceName: "Image")),
        Study(title: "스니커즈 어플 만드실분", subTitle: "안녕하세요 많은 참여 부탁드립니다. ", location: "강남구", date: "09/21 |", managerImage: #imageLiteral(resourceName: "Image-1"), mainImage: #imageLiteral(resourceName: "Image"))
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        tableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(StudyCell.self, forCellReuseIdentifier: StudyCell.cellId)
            $0.rowHeight = 100
        }
    }
    
    func layout() {
        view.addSubview(tableView)
        tableView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
}

extension StudyListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studyList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StudyCell.cellId, for: indexPath) as! StudyCell
        
        cell.do {
            $0.title1.text = studyList[indexPath.row].title
            $0.subTitle.text = studyList[indexPath.row].subTitle
            $0.location.text = studyList[indexPath.row].location
            $0.date.text = studyList[indexPath.row].date
            $0.managerImage.image = studyList[indexPath.row].managerImage
            $0.mainImage.image = studyList[indexPath.row].mainImage
        }
        
        return cell
    }
}
