//
//  MyApplyListView.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

final class MyApplyListView: UIViewController {
    var presenter: MyApplyListPresenterProtocol?
    var studyList: [ApplyStudy] = []
    lazy var applyList = UITableView()
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        attribute()
        layout()
    }
    
    private func attribute() {
        self.do {
            $0.title = "신청한 스터디"
            $0.view.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        self.applyList.do {
            $0.rowHeight = 80
            $0.register(MyApplyListCell.self, forCellReuseIdentifier: MyApplyListCell.myApplyListCellID)
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.refreshControl = refreshControl
        }
        refreshControl.do {
            $0.addTarget(self, action: #selector(viewDidLoad), for: .valueChanged)
        }
    }
    
    private func layout() {
        self.view.addSubview(applyList)

        self.applyList.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        }
    }
}

extension MyApplyListView: MyApplyListViewProtocol {
    func showStudyList(studies: [ApplyStudy]?) {
        if let tempStudies = studies {
            self.studyList = tempStudies
            applyList.reloadData()
            refreshControl.endRefreshing()
            
        }
    }
    
    func showLoading() { }
    func hideLoading() { }
}

extension MyApplyListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = applyList.dequeueReusableCell(withIdentifier: MyApplyListCell.myApplyListCellID,
                                                 for: indexPath) as! MyApplyListCell
        let data = studyList[indexPath.row]
        cell.setData(studies: data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let study = studyList[indexPath.row]
        presenter?.showStudyDetail(applyStudy: study)
    }
}
