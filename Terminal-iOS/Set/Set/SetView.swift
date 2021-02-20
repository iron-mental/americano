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
    var sections: [String] = ["", "계정", "알림", "정보", ""]
    var account: [String] = ["이메일", "SNS"]
    var noti: [String] = ["알림"]
    var settingData: [Setting] = [Setting(title: "앱버전", status: "1.0.1"),
                                  Setting(title: "공지사항"),
                                  Setting(title: "도움말"),
                                  Setting(title: "문의하기"),
                                  Setting(title: "이용약관"),
                                  Setting(title: "개인정보 취급방침")]
    var userManage: [String] = ["로그아웃", "회원탈퇴"]
    
    var userInfo: UserInfo? { didSet { self.settingList.reloadData() }}
    var emailVerify: Bool = false
    
    var presenter: SetPresenterProtocol?
    let settingList = UITableView(frame: .zero, style: .insetGrouped)
    let accountButton = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 25))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        if let emailVerify = userInfo?.emailVerified {
            self.emailVerify = emailVerify
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .appColor(.terminalBackground)
        
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
            $0.showsVerticalScrollIndicator = false
            $0.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.profileCellId)
            $0.register(DefaultCell.self, forCellReuseIdentifier: DefaultCell.defalutCellId)
            $0.register(NotiCell.self, forCellReuseIdentifier: NotiCell.notiCellId)
            $0.register(AccountCell.self, forCellReuseIdentifier: AccountCell.accountCellId)
            $0.register(UserManageCell.self, forCellReuseIdentifier: UserManageCell.userManageCellId)
        }
        
        accountButton.do {
            if emailVerify {
                $0.setTitle("인증완료", for: .normal)
                $0.setTitleColor(.appColor(.mainColor), for: .normal)
                $0.backgroundColor = .appColor(.eamilAuthComplete)
            } else {
                $0.setTitle("미인증", for: .normal)
                $0.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
                $0.backgroundColor = .appColor(.emailAuthRequire)
            }
            
            $0.layer.cornerRadius = 10
            $0.titleLabel?.font = UIFont.notosansMedium(size: 14)
            $0.addTarget(self, action: #selector(emailAuth), for: .touchUpInside)
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
    
    // MARK: Email Auth
    
    @objc func emailAuth() {
        
        /// 인증 여부에 따른 분기처리
        if emailVerify {
            self.showToast(controller: self, message: "이미 인증 하셨습니다.", seconds: 0.5)
        } else {
            TerminalAlertMessage.show(controller: self, type: .EmailAuthView)
            guard let alertView = (TerminalAlertMessage.alert.value(forKey: "contentViewController") as! UIViewController).view else { return }
            guard let view = alertView as? AlertBaseUIView else { return }
            view.completeButton.addTarget(self, action: #selector(emailAuthRequest), for: .touchUpInside)
        }
    }
    
    @objc func emailAuthRequest() {
        self.presenter?.emailAuthRequest()
    }
    
    @objc func logOutConfirmedDidTap() {
        TerminalAlertMessage.dismiss()
        presenter?.loggedOutConfirmed()
        let view = HomeView()
        let home = UINavigationController(rootViewController: view)
        /// RootViewController replace
        guard let window = UIApplication.shared.windows.first else { return }
        window.replaceRootViewController(home, animated: true, completion: nil)
    }
}

extension SetView: SetViewProtocol {
    func showLoading() {
        //        LoadingRainbowCat.show()
    }
    
    func hideLoading() {
        //        LoadingRainbowCat.hide()
    }
    
    func emailAuthResponse(result: Bool, message: String) {
        if result {
            TerminalAlertMessage.dismiss()
            self.showToast(controller: self, message: "이메일로 인증이 전송되었습니다.", seconds: 1)
        } else {
            self.showToast(controller: self, message: message, seconds: 1)
        }
    }
    
    func loggedOut() {
        TerminalAlertMessage.show(controller: self, type: .LogOutView)
        TerminalAlertMessage.getAlertCompleteButton().addTarget(self, action: #selector(logOutConfirmedDidTap), for: .touchUpInside)
    }
    
    // MARK: 환경설정 뷰가 로드시에 혹은 프로필 정보 수정시 유저 정보 갱신
    
    func showUserInfo(with userInfo: UserInfo) {
        self.userInfo = userInfo
        self.attribute()
        self.layout()
        self.hideLoading()
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
        } else if section == 3 {
            label.text = sections[3]
        }
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return account.count
        case 2:
            return noti.count
        case 3:
            return settingData.count
        case 4:
            return userManage.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 프로필 상세
        if indexPath.section == 0 && indexPath.row == 0 {
            presenter?.showProfileDetail()
        }
        
        // 로그아웃
        if indexPath.section == 4 && indexPath.row == 0 {
            presenter?.loggedOut()
        }
        
        // 회원탈퇴
        if indexPath.section == 4 && indexPath.row == 1 {
            presenter?.userWithdrawal()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let profileCell = settingList.dequeueReusableCell(withIdentifier: ProfileCell.profileCellId,
                                                              for: indexPath) as! ProfileCell
            if let userInfo = self.userInfo {
                profileCell.setData(data: userInfo)
            }
            profileCell.accessoryType = .disclosureIndicator
            return profileCell
        } else if indexPath.section == 1 {
            let accountCell = settingList.dequeueReusableCell(withIdentifier: AccountCell.accountCellId,
                                                              for: indexPath) as! AccountCell
            accountCell.title.text = account[indexPath.row]
            if indexPath.row == 0 {
                accountCell.accessoryView = accountButton
            }
            return accountCell
        } else if indexPath.section == 2 {
            let notiCell = settingList.dequeueReusableCell(withIdentifier: NotiCell.notiCellId,
                                                           for: indexPath) as! NotiCell
            notiCell.title.text = noti[0]
            return notiCell
        } else if indexPath.section == 3 {
            let defaultCell = settingList.dequeueReusableCell(withIdentifier: DefaultCell.defalutCellId,
                                                              for: indexPath) as! DefaultCell
            let data = settingData[indexPath.row]
            defaultCell.setData(data)
            if settingData[indexPath.row].status == nil {
                defaultCell.accessoryType = .disclosureIndicator
            }
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
