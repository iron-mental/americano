//
//  SetViewController.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/08/31.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Kingfisher
import CoreData
class SetView: UIViewController {
    // 섹션
    var sections: [String] = ["","계정", "알림", "정보", ""]
    var account: [String] = ["이메일", "SNS"]
    var noti: [String] = ["알림"]
    var settingData: [Setting] = [Setting(title: "앱버전", status: "1.0.1"),
                               Setting(title: "공지사항"),
                               Setting(title: "도움말"),
                               Setting(title: "문의하기"),
                               Setting(title: "이용약관"),
                               Setting(title: "개인정보 취급방침")]
    var userManage: [String] = ["로그아웃", "회원탈퇴"]
    
    var userInfo: UserInfo? {
        didSet {
            self.settingList.reloadData()
        }
    }
    
    var presenter: SetPresenterProtocol?
    let settingList = UITableView(frame: .zero, style: .insetGrouped)
    let accountButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 25))
     
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        self.do {
            $0.title = "설정"
            $0.view.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.navigationController?.navigationBar.standardAppearance = appearance
        }
        settingList.do {
            $0.alwaysBounceVertical = false
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.separatorColor = .clear
            $0.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.profileCellId)
            $0.register(DefaultCell.self, forCellReuseIdentifier: DefaultCell.defalutCellId)
            $0.register(NotiCell.self, forCellReuseIdentifier: NotiCell.notiCellId)
            $0.register(AccountCell.self, forCellReuseIdentifier: AccountCell.accountCellId)
            $0.register(UserManageCell.self, forCellReuseIdentifier: UserManageCell.userManageCellId)
        }
        accountButton.do {
            $0.setTitle("인증", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 10
        }
    }
    
    func layout() {
        self.view.addSubview(settingList)
        
        self.settingList.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
    }
    
    @objc func pushProfileModify(_ sender: UITapGestureRecognizer) {
        presenter?.showProfileDetail()
    }
}

extension SetView: SetViewProtocol {
    func loggedOut() {
        let view = HomeView()
        view.hidesBottomBarWhenPushed = true
        
        /// 로그아웃과 동시에  토큰 삭제
        KeychainWrapper.standard.remove(forKey: "refreshToken")
        navigationController?.pushViewController(view, animated: false)
    }
    
    // MARK: 환경설정 뷰가 로드시에 혹은 프로필 정보 수정시 유저 정보 갱신
    
    func showUserInfo(with userInfo: UserInfo) {
        self.userInfo = userInfo
    }
}

extension SetView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 1 : 32
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        } else {
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let label = UILabel().then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.textAlignment = .center
        }
        headerView.addSubview(label)
        label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 11).isActive = true
        if section == 1 {
            label.text = sections[1]
        } else if section == 2 {
            label.text = sections[2]
        } else if section == 3{
            label.text = sections[3]
        }
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return account.count
        } else if section == 2 {
            return noti.count
        } else if section == 3{
            return settingData.count
        } else if section == 4 {
            return userManage.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            presenter?.showProfileDetail()
        }
        if indexPath.section == 4 && indexPath.row == 0 {
            presenter?.loggedOut()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let profileCell = settingList.dequeueReusableCell(withIdentifier: ProfileCell.profileCellId,
                                                              for: indexPath) as! ProfileCell
            profileCell.selectionStyle = .none
            if let userInfo = self.userInfo {
                profileCell.setData(data: userInfo)
            }
            return profileCell
        } else if indexPath.section == 1 {
            let accountCell = settingList.dequeueReusableCell(withIdentifier: AccountCell.accountCellId,
                                                              for: indexPath) as! AccountCell
            accountCell.title.text = account[indexPath.row]
            if indexPath.row == 0 {
                accountCell.accessoryView = accountButton
            }
            accountCell.selectionStyle = .none
            return accountCell
        } else if indexPath.section == 2 {
            let notiCell = settingList.dequeueReusableCell(withIdentifier: NotiCell.notiCellId,
                                                           for: indexPath) as! NotiCell
            notiCell.title.text = noti[0]
            notiCell.selectionStyle = .none
            return notiCell
        } else if indexPath.section == 3 {
            let defaultCell = settingList.dequeueReusableCell(withIdentifier: DefaultCell.defalutCellId,
                                                              for: indexPath) as! DefaultCell
            let data = settingData[indexPath.row]
            defaultCell.setData(data)
            if settingData[indexPath.row].status == nil {
                defaultCell.accessoryType = .disclosureIndicator
            }
            defaultCell.selectionStyle = .none
            return defaultCell
        } else if indexPath.section == 4 {
            let userManageCell = settingList.dequeueReusableCell(withIdentifier: UserManageCell.userManageCellId,
                                                                 for: indexPath) as! UserManageCell
            let data = userManage[indexPath.row]
            userManageCell.title.text = data
            return userManageCell
        } else {
            return UITableViewCell()
        }
    }
}

