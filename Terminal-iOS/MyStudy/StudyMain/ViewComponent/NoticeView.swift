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
    
    var noticeList: [Notice] = [Notice(title: "가이드 라인입니다가이드 라인입니다가이드 라인입니다가이드 라인입니다가이드 라인입니다가이드 라인입니다", contents: "첫번모임 진행시 가이드 라인입니다모임 진행시 가이드 라인입니다모임 진행시 가이드 라인입니다모임 진행시 가이드 라인입니다모임 진행시 가이드 라인입니다모임 진행시 가이드 라인입니다모임 진행시 가이드 라인입니다모임 진행시 가이드 라인입니다모임 진행시 가이드 라인입니다모임 진행시 가이드 라인입니다모임 진행시 가이드 라인입니다째", pinned: true),
                                Notice(title: "가이드 라인입니다", contents: "두번쨰", pinned: false),
                                Notice(title: "가이드 라인입니다", contents: "세번째", pinned: false),
                                Notice(title: "가이드 라인입니다", contents: "네번째", pinned: true),
                                Notice(title: "가이드 라인입니다", contents: "다섯번째", pinned: false),
                                Notice(title: "가이드 라인입니다", contents: "여섯번째", pinned: false),
                                Notice(title: "가이드 라인입니다", contents: "일곱번째", pinned: true),
                                Notice(title: "가이드 라인입니다", contents: "여덟번째", pinned: false)]
    var pinnedNotiArr: [Notice] = []
    var notiArr: [Notice] = []
    lazy var notice = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sorted()
        attribute()
        layout()
    }
    
    func sorted() {
        pinnedNotiArr = noticeList.filter { $0.pinned }
        notiArr = noticeList.filter { !$0.pinned }
        print(pinnedNotiArr)
        print(notiArr)
    }
    func attribute() {
        notice.do {
            $0.register(NoticeCell.self, forCellReuseIdentifier: NoticeCell.noticeCellID)
            $0.register(PinnedNoticeCell.self, forCellReuseIdentifier: PinnedNoticeCell.pinnedNoticeCellID)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return pinnedNotiArr.count
        } else if section == 1 {
            return notiArr.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noticeCell = notice.dequeueReusableCell(withIdentifier: NoticeCell.noticeCellID, for: indexPath) as! NoticeCell
        
        if indexPath.section == 0 {
            noticeCell.noticeLabel.text = "필독"
            noticeCell.noticeBackground.backgroundColor = UIColor.appColor(.pinnedNoticeColor)
            noticeCell.setData(pinnedNotiArr[indexPath.row])
        } else if indexPath.section == 1 {
            noticeCell.setData(notiArr[indexPath.row])
        }
        return noticeCell
    }
}
