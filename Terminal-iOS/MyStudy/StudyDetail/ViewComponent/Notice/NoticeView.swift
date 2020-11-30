//
//  NoticeView.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/01.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class NoticeView: UIViewController {
    var presenter: NoticePresenterProtocol?
    var studyID: Int?
    var noticeList: [Notice] = []
    var pinnedNotiArr: [Notice] = []
    var notiArr: [Notice] = []
    lazy var notice = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad(studyID: studyID!)
        sorted()
        attribute()
        layout()
    }
    
    func sorted() {
        pinnedNotiArr = noticeList.filter { $0.pinned! }
        notiArr = noticeList.filter { !$0.pinned! }
    }
    func attribute() {
        notice.do {
            $0.register(NoticeCell.self, forCellReuseIdentifier: NoticeCell.noticeCellID)
            $0.delegate = self
            $0.dataSource = self
            $0.prefetchDataSource = self
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

extension NoticeView: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        if section == 0 {
            headerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        } else if section == 1 {
            headerView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
        return headerView
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedNotice: Notice?
        if indexPath.section == 0 {
            selectedNotice = pinnedNotiArr[indexPath.row]
        } else {
            selectedNotice = notiArr[indexPath.row]
        }
        selectedNotice!.studyID = studyID
        presenter?.celldidTap(notice: selectedNotice!, parentView: self)
    }
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            if noticeList.count - 1 == indexPath.row {
                presenter?.didScrollEnded(studyID: studyID!)
            }
        }
    }
}

extension NoticeView: NoticeViewProtocol {
    func showNoticeList(noticeList: [Notice]) {
        self.noticeList += noticeList
        sorted()
        notice.reloadData()
    }
    func noticeReloadData() {
        notice.reloadData()
        view.layoutIfNeeded()
    }
    func showMessage(message: String) {
        print(message)
    }
}
