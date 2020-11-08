//
//  NoticeView.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/01.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class NoticeView: UIViewController {
    let noticeTitleText = ["모임 진행시 가이드 라인입니다", "모임 진행시 가이드 라인입니다", "모임 진행시 가이드 라인입니다", "모임 진행시 가이드 라인입니다", "모임 진행시 가이드 라인입니다","모임 진행시 가이드 라인입니다", "모임 진행시 가이드 라인입니다", "모임 진행시 가이드 라인입니다", "모임 진행시 가이드 라인입니다", "모임 진행시 가이드 라인입니다"]
    
    lazy var notice = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    func attribute() {
        notice.do {
            $0.register(NoticeCell.self, forCellReuseIdentifier: NoticeCell.cellID)
            $0.delegate = self
            $0.dataSource = self
            $0.bounces = false
            $0.rowHeight = Terminal.convertHeigt(value: 123)
        }
    }
    
    func layout() {
        view.addSubview(notice)
        notice.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        }
    }
}

extension NoticeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeTitleText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notice.dequeueReusableCell(withIdentifier: NoticeCell.cellID, for: indexPath) as! NoticeCell
        cell.noticeTitle.text = noticeTitleText[indexPath.row]
        return cell
    }
}
