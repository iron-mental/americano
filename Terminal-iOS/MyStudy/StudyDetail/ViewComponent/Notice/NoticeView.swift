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
    var firstNoticeList: [Notice] = []
    var secondNoticeList: [Notice] = []
    lazy var notice = UITableView(frame: CGRect.zero, style: .plain)
    var state: StudyDetailViewState?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewLoad()
    }
    
    func viewLoad() {
        firstNoticeList.removeAll()
        secondNoticeList.removeAll()
        attribute()
        layout()
        presenter?.viewDidLoad(studyID: studyID!)
    }
    
    func attribute() {
        self.do {
            $0.view.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        notice.do {
            $0.register(NoticeCell.self, forCellReuseIdentifier: NoticeCell.noticeCellID)
            $0.delegate = self
            $0.dataSource = self
            $0.prefetchDataSource = self
            $0.bounces = false
            $0.rowHeight = Terminal.convertHeight(value: 123)
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
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
        var count = 0
        count += firstNoticeList.isEmpty ? 0 : 1
        count += secondNoticeList.isEmpty ? 0 : 1
        
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .red
        if section == 0 {
            headerView.backgroundColor = UIColor.appColor(.terminalBackground)
        } else if section == 1 {
            headerView.backgroundColor = secondNoticeList.isEmpty ? UIColor.appColor(.terminalBackground) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return firstNoticeList.count
        } else if section == 1 {
            return secondNoticeList.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noticeCell = notice.dequeueReusableCell(withIdentifier: NoticeCell.noticeCellID, for: indexPath) as! NoticeCell
        
        if indexPath.section == 0 {
            noticeCell.setData(firstNoticeList[indexPath.row])
        } else if indexPath.section == 1 {
            noticeCell.setData(secondNoticeList[indexPath.row])
        }
        return noticeCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedNotice: Notice?
        
        if indexPath.section == 0 {
            selectedNotice = firstNoticeList[indexPath.row]
        } else {
            selectedNotice = secondNoticeList[indexPath.row]
        }
        selectedNotice!.studyID = self.studyID
        guard let currentState = self.state else { return }
        presenter?.celldidTap(notice: selectedNotice!, parentView: self, state: currentState)
        
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            if indexPath.section == 0 {
                if firstNoticeList.count - 1 == indexPath.row {
                    presenter?.didScrollEnded(studyID: studyID!)
                }
            } else {
                if secondNoticeList.count - 1 == indexPath.row {
                    presenter?.didScrollEnded(studyID: studyID!)
                }
            }
        }
    }
}

extension NoticeView: NoticeViewProtocol {
    func showNoticeList(firstNoticeList: [Notice]?, secondNoticeList: [Notice]?) {
        if let first = firstNoticeList {
            self.firstNoticeList = first
        }
        if let second = secondNoticeList {
            self.secondNoticeList = second
        }
        notice.reloadData()
        LoadingRainbowCat.hide()
    }
    func showLoading() {
        LoadingRainbowCat.show()
    }
    
    func showNoticeList(noticeList: [Notice]) {
        notice.reloadData()
        LoadingRainbowCat.hide()
    }
    func showMessage(message: String) {
        LoadingRainbowCat.hide()
    }
}
