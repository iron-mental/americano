//
//  MyApplyStudyModifyView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/11.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class MyApplyStudyModifyView: UIViewController {
    var presenter: MyApplyStudyModifyPresenterInputProtocol?
    var studyID: Int?
    var applyTextField = UITextField()
    var guideLabel = UILabel()
    var admitButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let id = studyID else { return }
        presenter?.viewDidLoad(studyID: id)
        layout()
    }
    
    func attribute() {
        self.do {
            $0.title = "신청 상세"
        }
        view.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        applyTextField.do {
            $0.addLeftPadding()
            $0.placeholder = "안녕하세요"
            $0.backgroundColor = UIColor.appColor(.InputViewColor)
            $0.sizeToFit()
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.layer.borderWidth = 0.1
            $0.layer.borderColor = UIColor.gray.cgColor
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
    }
    
    func layout() {
        [ guideLabel, admitButton, applyTextField ].forEach { view.addSubview($0) }
        
        guideLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Terminal.convertWidth(value: 30)).isActive = true
        }
        
        applyTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: guideLabel.leadingAnchor, constant: Terminal.convertWidth(value: 30)).isActive = true
            $0.topAnchor.constraint(equalTo: guideLabel.bottomAnchor, constant: Terminal.convertHeigt(value: 30)).isActive = true
            $0.trailingAnchor.constraint(equalTo: guideLabel.trailingAnchor, constant: -Terminal.convertWidth(value: 30)).isActive = true
        }
        
        admitButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: applyTextField.bottomAnchor, constant: Terminal.convertHeigt(value: 23)).isActive = true
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
        TerminalAlertMessage.show(controller: self, type: .StudyApplyDeleteView)
    }
}

extension MyApplyStudyModifyView: MyApplyStudyModifyViewProtocol {
    
    func showModifyApplyMessageResult(message: String) {
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
