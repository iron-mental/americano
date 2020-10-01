//
//  SetViewController.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/08/31.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SetView: UIViewController {
    
    // 섹션
    var sections: [String] = ["계정", "알림", "정보"]
    
    
    var account: [String] = ["이메일", "SNS"]
    var noti: [String] = ["알림"]
    var tempData: [Setting] = [Setting(title: "앱버전", status: "1.0.1"),
                               Setting(title: "공지사항", status: ">"),
                               Setting(title: "도움말", status: ">"),
                               Setting(title: "문의하기", status: ">"),
                               Setting(title: "이용약관", status: ">"),
                               Setting(title: "개인정보 취급방침", status: ">")]
    
    var presenter: SetViewPresenterProtocol?
    
    let frameView = UIView()
    let profile = UIImageView(frame: CGRect(x: 0, y: 0,
                                            width: UIScreen.main.bounds.height * 0.1,
                                            height: UIScreen.main.bounds.height * 0.1))
    let name = UILabel()
    let descript = UILabel()
    let location = UILabel()
    let settingList = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.terminalBackground)
        attribute()
        layout()
    }
        
    func attribute() {
        profile.do {
            $0.contentMode = .scaleAspectFill
            $0.image = #imageLiteral(resourceName: "leehi")
            $0.layer.cornerRadius = $0.frame.size.width/2
            $0.clipsToBounds = true
        }
        name.do {
            $0.text = "이하이"
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = $0.font.withSize(20)
        }
        descript.do {
            $0.text = "iOS를 공부하는 중입니다. 잘 부탁드립니다."
            $0.numberOfLines = 0
            $0.font = $0.font.withSize(16)
        }
        location.do {
            $0.text = "서울시 마포구"
            $0.font = $0.font.withSize(13)
        }
        settingList.do {
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.sectionHeaderHeight = 40
            $0.separatorColor = .clear
            $0.register(DefaultCell.self, forCellReuseIdentifier: DefaultCell.defalutCellId)
            $0.register(NotiCell.self, forCellReuseIdentifier: NotiCell.notiCellId)
            $0.register(AccountCell.self, forCellReuseIdentifier: AccountCell.accountCellId)
        }
    }
    
    func layout() {
        view.addSubview(frameView)
        frameView.layer.zPosition = 1
//        frameView.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.5)
        frameView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.13).isActive = true
        }
        
        view.addSubview(profile)
        view.addSubview(name)
        view.addSubview(descript)
        view.addSubview(location)
        view.addSubview(settingList)
        
        profile.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: frameView.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
            $0.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.1).isActive = true
            $0.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.1).isActive = true
        }
        name.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: frameView.topAnchor, constant: 30).isActive = true
            $0.leadingAnchor.constraint(equalTo: profile.trailingAnchor, constant: 20).isActive = true
        }
        descript.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: profile.trailingAnchor, constant: 20).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -3).isActive = true
        }
        location.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: frameView.topAnchor, constant: 30).isActive = true
            $0.trailingAnchor.constraint(equalTo: frameView.trailingAnchor, constant: -20).isActive = true
        }
        settingList.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: frameView.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
}

extension SetView: SetViewProtocol {
    
}

extension SetView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        
        if section == 0 {
            label.text = sections[0]
        } else if section == 1 {
            label.text = sections[1]
        } else if section == 2{
            label.text = sections[2]
        }
        return label
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return account.count
        } else if section == 1 {
            return noti.count
        } else if section == 2{
            return tempData.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let accountCell = tableView.dequeueReusableCell(withIdentifier: AccountCell.accountCellId,
                                                        for: indexPath) as! AccountCell
        
        let notiCell = tableView.dequeueReusableCell(withIdentifier: NotiCell.notiCellId,
                                                     for: indexPath) as! NotiCell
        
        let defaultCell = tableView.dequeueReusableCell(withIdentifier: DefaultCell.defalutCellId,
                                                        for: indexPath) as! DefaultCell
        
        if indexPath.section == 0 {
            accountCell.title.text = account[indexPath.row]
            return accountCell
        } else if indexPath.section == 1 {
            notiCell.title.text = noti[0]
            return notiCell
        } else if indexPath.section == 2 {
            let data = tempData[indexPath.row]
            defaultCell.setData(data)
            return defaultCell
        } else {
            return UITableViewCell()
        }
    }
}
