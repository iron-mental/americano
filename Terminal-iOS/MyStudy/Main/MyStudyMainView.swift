//
//  MyStudyMainView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class MyStudyMainView: UIViewController {
    var presenter: MyStudyMainPresenterProtocol?
    
    var moreButton: UIBarButtonItem?
    var tableView = UITableView()
    var alarmButton = badgeBarButtonItem()
    var tempButton: UIBarButtonItem?
    var rightBarButtomItem: UIBarButtonItem?
    
    //alarmbutton 쇼잉을 위한 임시 변수!! 곧 삭제됩니다.
    var tempCountForBadge = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        view.do {
            $0.backgroundColor = UIColor.appColor(.testColor)
        }
        moreButton = UIBarButtonItem(title: "", style: .done, target: self, action: #selector(moreButtonAction(_ :)))
        moreButton?.do {
            $0.image = #imageLiteral(resourceName: "more")
            $0.tintColor = .white
        }
        tempButton = UIBarButtonItem(title: "임시버튼", style: .done, target: self, action: #selector(goToLoginAction(_ :)))
        self.do {
            $0.title = "내 스터디"
            $0.navigationItem.rightBarButtonItems = [moreButton!, alarmButton, tempButton!]
            $0.navigationController?.navigationBar.backgroundColor = UIColor.appColor(.testColor)
            $0.navigationController?.navigationBar.prefersLargeTitles = true
        }
        tableView.do {
            $0.backgroundColor = UIColor.appColor(.testColor)
            $0.register(MyStudyMainTableViewCell.self, forCellReuseIdentifier: MyStudyMainTableViewCell.identifier)
            $0.delegate = self
            $0.dataSource = self
        }
        alarmButton.do {
            $0.button.addTarget(self, action: #selector(alarmButtonAction(_:)), for: .touchUpInside)
        }
        
    }
    
    func layout() {
        view.addSubview(tableView)
        
        tableView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
    }
    
    @objc func moreButtonAction(_ sender: UIBarButtonItem) {
        let alert =  UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let edit =  UIAlertAction(title: "스터디 편집", style: .default) {_ in }
        let temp =  UIAlertAction(title: "여긴뭐들어갑니까", style: .default) {_ in }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        [edit,temp,cancel].forEach {
            alert.addAction($0)
        }
        present(alert, animated: true, completion: nil)
    }
    
    @objc func alarmButtonAction(_ sender: UIBarButtonItem) {
        alarmButton.badgeLabel.isHidden = false
        tempCountForBadge += 1
        alarmButton.badgeLabel.text = "\(tempCountForBadge)"
    }
    
    @objc func goToLoginAction(_ sender: UIBarButtonItem) {
        let view = IntroView()
        view.modalPresentationStyle = .fullScreen
        view.guideLabel.text = "이메일을\n입력해 주세요"
        view.emailTextfield.placeholder = "abc1234@terminal.com"
        view.state = .emailInput
        self.present(view, animated: true)
//        let view = HomeView()

    }
}

extension MyStudyMainView: MyStudyMainViewProtocol {
    
}

extension MyStudyMainView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyStudyMainTableViewCell.identifier) as! MyStudyMainTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (91.7/667) * view.bounds.height
    }
}
