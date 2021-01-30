//
//  MyApplyStudyModifyView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/11.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class MyApplyStudyModifyView: UIViewController {
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    var presenter: MyApplyStudyModifyPresenterInputProtocol?
    var studyID: Int?
    var applyTextField = UITextField()
    var guideLabel = UILabel()
    var admitButton = UIButton()
    var bottomAnchor: NSLayoutConstraint?
    var keyboardHeight: CGFloat = 0.0
    var parentView: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let id = studyID else { return }
        presenter?.viewDidLoad(studyID: id)
        layout()
        applyTextField.becomeFirstResponder()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        keyboardHeight = keyboardRectangle.height
        bottomAnchor?.constant = -(keyboardHeight + 15)
        bottomAnchor?.isActive = true
        view.layoutIfNeeded()
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
            $0.topAnchor.constraint(equalTo: guideLabel.bottomAnchor, constant: Terminal.convertHeigt(value: 30)).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - (Terminal.convertWidth(value: 60))).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 45)).isActive = true
            
        }
        bottomAnchor = admitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        admitButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            bottomAnchor?.isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 335)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 45)).isActive = true
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
        dismiss(animated: true) { [self] in
            if let myApplyStudyInfoView = parentView as? MyApplyStudyInfoView {
                myApplyStudyInfoView.applyMessageLabel.label.text = applyTextField.text
            }
        }
    }
    
    func showMyApplyStudyDetail(message: String) {
        applyTextField.text = message
        attribute()
    }
    
    func showError() {
        print("MyApplyStudyDetailView 에서 난 오류")
    }
}
