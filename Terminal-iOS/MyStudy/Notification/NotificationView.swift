//
//  NotificationView.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class NotificationView: UIViewController {
    let tableView = UITableView()
    
    let dummy: [Noti] = [Noti(title: "Swift 정복자", explain: "정재인님이 참여하셨습니다.", action: "프로필 보기"),
                         Noti(title: "안드로이드 정복자", explain: "고영찬님이 참여하셨습니다.", action: "인사하러 가기"),
                         Noti(title: "갓서버 양육소", explain: "갓철님이 참여하셨습니다.", action: "살펴보러가기"),
                         Noti(title: "드루와 드루와", explain: "최용권님이 공지사항 등록했어요.", action: "공지사항 보러가기")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        attribute()
        layout()
    }
    
    func attribute() {
        tableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(NotificationCell.self, forCellReuseIdentifier: NotificationCell.cellID)
            $0.rowHeight = Terminal.convertHeigt(value: 80)
        }
    }
    func layout() {
        view.addSubview(tableView)
        tableView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
    }
}

extension NotificationView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCell.cellID, for: indexPath) as! NotificationCell
        let data = dummy[indexPath.row]
        
        cell.setData(data.title, data.explain, data.action)
        
        return cell
    }
}
