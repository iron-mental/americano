//
//  MyStudyMainView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

enum MyStudyMainViewState {
    case normal
    case edit
}

class MyStudyMainView: UIViewController {
    var presenter: MyStudyMainPresenterProtocol?
    var state: MyStudyMainViewState = .normal
    var moreButton: UIBarButtonItem?
    var tableView = UITableView()
    var alarmButton = badgeBarButtonItem()
    var tempButton: UIBarButtonItem?
    var rightBarButtomItem: UIBarButtonItem?
    var dismissEditViewButtonItem: UIBarButtonItem?
    //alarmbutton 쇼잉을 위한 임시 변수!! 곧 삭제됩니다.
    var tempCountForBadge = 0
    var tempArrayForCheck: [Int] = []
    
    
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
            $0.navigationController?.navigationBar.backgroundColor = UIColor.appColor(.testColor)
        }
        tableView.do {
            $0.backgroundColor = UIColor.appColor(.testColor)
            $0.register(MyStudyMainTableViewCell.self, forCellReuseIdentifier: MyStudyMainTableViewCell.identifier)
            $0.delegate = self
            $0.dataSource = self
        }
        alarmButton.do {
            $0.button.addTarget(self, action: #selector(alarmButtonAction), for: .touchUpInside)
        }
        dismissEditViewButtonItem = UIBarButtonItem(title: "나가기", style: .done, target: self, action: #selector(dismissEditViewButtonItemAction))
    }
    
    func layout() {
        switch state {
        case .edit:
            self.navigationItem.leftBarButtonItems = [dismissEditViewButtonItem!]
            break
        case .normal:
            self.navigationItem.rightBarButtonItems = [moreButton!, alarmButton, tempButton!]
            break
        }
        
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
        let edit =  UIAlertAction(title: "스터디 편집", style: .default) { (action) in self.editButtonAction() }
        let temp =  UIAlertAction(title: "여긴뭐들어갑니까", style: .default) {_ in }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        [edit,temp,cancel].forEach {
            alert.addAction($0)
        }
        present(alert, animated: true, completion: nil)
    }
    
    @objc func dismissEditViewButtonItemAction() {
        self.navigationItem.leftBarButtonItems?.removeAll()
        state = .normal
        layout()
        tableView.reloadData()
    }
    
    @objc func editButtonAction() {
        self.navigationItem.rightBarButtonItems?.removeAll()
        state = .edit
        layout()
        tableView.reloadData()
    }
    
    @objc func alarmButtonAction() {
        alarmButton.badgeLabel.isHidden = false
        tempCountForBadge += 1
        alarmButton.badgeLabel.text = "\(tempCountForBadge)"
        let view = NotificationView()
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    @objc func goToLoginAction(_ sender: UIBarButtonItem) {
        let view = IntroView()
        let navigationController = UINavigationController(rootViewController: view)
        navigationController.modalPresentationStyle = .fullScreen
        view.state = .emailInput
        self.present(navigationController, animated: true)
    }
}

extension MyStudyMainView: MyStudyMainViewProtocol {
    
}

extension MyStudyMainView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyStudyMainTableViewCell.identifier) as! MyStudyMainTableViewCell
        switch state {
        case .normal:
            cell.checkBox.isHidden = true
            [cell.newMemberLabel, cell.newChatLabel, cell.newNoticeLabel].forEach { $0.isHidden = false }
            break
        case .edit:
            cell.checkBox.isHidden = false
            [cell.newMemberLabel, cell.newChatLabel, cell.newNoticeLabel].forEach { $0.isHidden = true }
            
            if tempArrayForCheck.contains(indexPath.row) {
                    cell.checkBox.backgroundColor = UIColor.appColor(.mainColor)
                } else {
                    cell.checkBox.backgroundColor = UIColor.appColor(.testColor)
                }
            break
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (91.7/667) * view.bounds.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch state {
        case .normal:
            let view = StudyDetailView()
            view.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(view, animated: true)
            break
        case .edit:
            if tempArrayForCheck.contains(indexPath.row) {
                tempArrayForCheck.remove(at: tempArrayForCheck.firstIndex(of: indexPath.row)!)
            } else {
                tempArrayForCheck.append(indexPath.row)
            }
            break
        }
        print(tempArrayForCheck)
        tableView.reloadData()
    }
}
