//
//  ApplyUserView.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

final class ApplyUserView: UIViewController {
    var studyID: Int?
    var presenter: ApplyUserPresenterProtocol?
    var userList: [ApplyUser] = []
    lazy var applyUserList = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad(studyID: studyID!)
        attribute()
        layout()
    }
    
    private func attribute() {
        self.do {
            $0.title = "신청자 목록"
        }
        self.applyUserList.do {
            $0.estimatedRowHeight = 80
            $0.rowHeight = UITableView.automaticDimension
            $0.register(ApplyUserCell.self, forCellReuseIdentifier: ApplyUserCell.applyUserCellID)
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
    }
    
    private func layout() {
        self.view.addSubview(applyUserList)
        
        self.applyUserList.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        }
    }
}

extension ApplyUserView: ApplyUserViewProtocol {
    func showUserList(userList: [ApplyUser]?) {
        if let result = userList {
            self.userList = result
            applyUserList.reloadData()
        }
        navigationController?.viewControllers.forEach {
            if let myStudyDetailView  = $0 as? MyStudyDetailViewProtocol {
                myStudyDetailView.applyState = false
            }
        }
    }
    
    func showError(message: String) {
        showToast(controller: self, message: message, seconds: 1) {
            self.navigationController?.viewControllers.forEach {
                if let myStudyDetailView  = $0 as? MyStudyDetailViewProtocol {
                    myStudyDetailView.applyState = false
                }
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func showLoading() {
        LoadingRainbowCat.show(caller: self)
    }
    func hideLoading() {
        LoadingRainbowCat.hide(caller: self)
    }
}

extension ApplyUserView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userList.isEmpty {
            tableView.setEmptyView(type: .ApplyUserListEmptyViewType)
            return 0
        } else {
            tableView.restore()
            return userList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = applyUserList.dequeueReusableCell(withIdentifier: ApplyUserCell.applyUserCellID,
                                                 for: indexPath) as! ApplyUserCell
        let data = userList[indexPath.row]
        cell.setData(userList: data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = studyID else { return }
        presenter?.showUserInfoDetail(userInfo: userList[indexPath.row], studyID: id)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
