//
//  DelegateHostView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/21.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit
import AudioToolbox

class DelegateHostView: UIViewController {
    var presenter: DelegateHostPresenterProtocol?
    var userList: [Participate]?
    var userTableView = UITableView()
    var guideLabel = UILabel()
    var selectedUserID = 0
    var studyID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        self.do {
            $0.title = "방장을 위임해보세요"
        }
        view.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        guideLabel.do {
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
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Terminal.convertHeight(value: 10)).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Terminal.convertWidth(value: 10)).isActive = true
        }
        userTableView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: guideLabel.bottomAnchor, constant: Terminal.convertHeight(value: 20)).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
    
    @objc func delegateCompelteButtonDidTap() {
        presenter?.delegateHostButtonDidTap(newLeader: selectedUserID)
        TerminalAlertMessage.dismiss()
    }
}

extension DelegateHostView: DelegateHostViewProtocol {
    func showDelegateHostResult(message: String) {
        showToast(controller: self, message: message, seconds: 1) { [self] in
            navigationController?.popViewController(animated: true)
            ((navigationController?.viewControllers[1] as! MyStudyDetailView).VCArr[0] as! NoticeView).viewDidLoad()
            ((navigationController?.viewControllers[1] as! MyStudyDetailView).VCArr[1] as! StudyDetailView).studyID = studyID!
            ((navigationController?.viewControllers[1] as! MyStudyDetailView).VCArr[2] as! TempChatView).viewDidLoad()
        }
    }
    
    func showError(message: String) {
        showToast(controller: self, message: message, seconds: 1)
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
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
        TerminalAlertMessage.show(controller: self, type: .DelegateHostConfirmView)
        ((TerminalAlertMessage.alert.value(forKey: "contentViewController") as! UIViewController).view as! AlertBaseUIView).completeButton.addTarget(self, action: #selector(delegateCompelteButtonDidTap), for: .touchUpInside)

    }
}
