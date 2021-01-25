//
//  MyApplyStudyDetailView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/11.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class MyApplyStudyDetailView: UIViewController {
    var presenter: MyApplyStudyDetailPresenterInputProtocol?
    var studyID: Int?
    var inputBackgroundView = UIView()
    var applyTextField = UITextField()
    var guideLabel = UILabel()
    var admitButton = UIButton()
    var cancelButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let id = studyID else { return }
        presenter?.viewDidLoad(studyID: id)
        layout()
    }
    
    func attribute() {
        self.do {
            $0.navigationItem.title = "스터디 신청 상세"
        }
        view.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        inputBackgroundView.do {
            $0.backgroundColor = UIColor.appColor(.InputViewColor)
            $0.layer.cornerRadius = 20
            $0.layer.masksToBounds = true
        }
        applyTextField.do {
            $0.addLeftPadding()
            $0.placeholder = "안녕하세요"
            $0.backgroundColor = UIColor.appColor(.InputViewColor)
        }
        guideLabel.do {
            $0.text = "가입 인사를 수정해보세요"
            $0.numberOfLines = 0
            $0.font = UIFont.boldSystemFont(ofSize: 30)
        }
        admitButton.do {
            $0.setTitle("완료", for: .normal)
            $0.backgroundColor = UIColor(named: "key")
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.addTarget(self, action: #selector(didClickButtonDidTap), for: .touchUpInside)
        }
        cancelButton.do {
            $0.setTitle("신청 취소", for: .normal)
            $0.backgroundColor = .red
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.addTarget(self, action: #selector(didCancelButtonDidTap), for: .touchUpInside)
        }
    }
    
    func layout() {
        [inputBackgroundView, guideLabel, admitButton, cancelButton].forEach { view.addSubview($0) }
        [applyTextField].forEach { inputBackgroundView.addSubview($0) }
        
        inputBackgroundView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -Terminal.convertHeigt(value: 100)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 75).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 300).isActive = true
        }
        guideLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Terminal.convertWidth(value: 30)).isActive = true
        }
        
        applyTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: inputBackgroundView.leadingAnchor, constant: Terminal.convertWidth(value: 30)).isActive = true
            $0.centerYAnchor.constraint(equalTo: inputBackgroundView.centerYAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: inputBackgroundView.trailingAnchor, constant: -Terminal.convertWidth(value: 30)).isActive = true
        }
        
        admitButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: inputBackgroundView.bottomAnchor, constant: Terminal.convertHeigt(value: 23)).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Terminal.convertWidth(value: -15) ).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Terminal.convertWidth(value: 15) ).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 50)).isActive = true
        }
        cancelButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: admitButton.bottomAnchor, constant: Terminal.convertHeigt(value: 23)).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Terminal.convertWidth(value: -15) ).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Terminal.convertWidth(value: 15) ).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 50)).isActive = true
        }
    }
    @objc func didClickButtonDidTap() {
        if let newMessage = applyTextField.text {
            presenter?.admitButtonDidTap(newMessage: newMessage)
        }
    }
    @objc func didCancelButtonDidTap() {
        TerminalAlertMessage.show(type: .studyApplyDeleteView)
        (TerminalAlertMessage.alertView as? AlertBaseUIView)?.completeButton.addTarget(self, action: #selector(didCancelAction), for: .touchUpInside)
    }
    @objc func didCancelAction() {
        presenter?.cancelButtonDidTap()
    }
}

extension MyApplyStudyDetailView: MyApplyStudyDetailViewProtocol {
    
    func showModifyApplyMessageResult(message: String) {
        //토스트 메세지를 띄워주며 << 요놈 개발해야겠음!!
        navigationController?.popViewController(animated: true)
        (navigationController?.viewControllers.last as? MyApplyListViewProtocol)?.presenter?.viewDidLoad()
    }
    
    func showMyApplyStudyDetail(message: String) {
        applyTextField.text = message
        attribute()
    }
    
    func showError() {
        print("MyApplyStudyDetailView 에서 난 오류")
    }
    
    func showDeleteApply(message: String) {
        navigationController?.popViewController(animated: true)
        (navigationController?.viewControllers.last as? MyApplyListViewProtocol)?.presenter?.viewDidLoad()
    }
}
