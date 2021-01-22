//
//  DelegateHostView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/21.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class DelegateHostView: UIViewController {
    var presenter: DelegateHostPresenterProtocol?
    var userList: [Participate]?
    var userTableView = UITableView()
    var guideLabel = UILabel()
    var selectedUserID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        
    }
    
    func attribute() {
        view.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        guideLabel.do {
            $0.text = "방장을 위임할 멤버를 골라주세요"
            $0.numberOfLines = 0
            $0.font = UIFont.boldSystemFont(ofSize: 28)
            
        }
        userTableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.register(DelegateHostTableViewCell.self, forCellReuseIdentifier: DelegateHostTableViewCell.id)
        }
    }
    
    func layout() {
        [ guideLabel, userTableView ].forEach { view.addSubview($0) }
        
        guideLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Terminal.convertHeigt(value: 10)).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Terminal.convertWidth(value: 10)).isActive = true
        }
        userTableView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: guideLabel.bottomAnchor, constant: Terminal.convertHeigt(value: 20)).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
    
    @objc func delegateCompelteButtonDidTap() {
        presenter?.delegateHostButtonDidTap(newLeader: selectedUserID)
        (TerminalAlertMessage.alertView as! AlertMessageView).completeButton.removeTarget(nil, action: nil, for: .allEvents)
    }
}

extension DelegateHostView: DelegateHostViewProtocol {
    func showDelegateHostResult(message: String) {
        showToast(controller: self, message: message, seconds: 1) {
            self.navigationController?.popViewController(animated: true)
//            (navigationController?.viewControllers.last as! MyStudyDetailView).VCArr[0]
//            (navigationController?.viewControllers.last as! MyStudyDetailView).VCArr[1]
//            (navigationController?.viewControllers.last as! MyStudyDetailView).VCArr[2]
        }
    }
    
    func showError(message: String) {
        
        showToast(controller: self, message: message, seconds: 1, completion: nil)
        
    }
}

extension DelegateHostView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DelegateHostTableViewCell.id, for: indexPath) as! DelegateHostTableViewCell
        cell.setData(data: userList![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedUserID = userList![indexPath.row].userID
        TerminalAlertMessage.show(type: .DelegateHostConfirmView)
        (TerminalAlertMessage.alertView as! AlertMessageView).completeButton.addTarget(self, action: #selector(delegateCompelteButtonDidTap), for: .touchUpInside)
//        navigationController?.popViewController(animated: true)
    }
}
