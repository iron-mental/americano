//
//  SNSModifyView.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SNSModifyView: UIViewController {
    var presenter: SNSModifyPresenterProtocol?
    
    var github: String = ""
    var linkedin: String = ""
    var web: String = ""
    
    lazy var snsModifyView = ProfileSNSModifyView()
    lazy var completeButton = UIButton()
    var accessoryCompleteButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }

    func attribute() {
        self.do {
            $0.hideKeyboardWhenTappedAround()
            $0.view.backgroundColor = .appColor(.terminalBackground)
            $0.title = "SNS 수정"
            $0.view.backgroundColor = .appColor(.terminalBackground)
        }
        self.snsModifyView.do {
            $0.firstTextFeield.text = self.github
            $0.firstTextFeield.inputAccessoryView = accessoryCompleteButton
            $0.secondTextField.text = self.linkedin
            $0.secondTextField.inputAccessoryView = accessoryCompleteButton
            $0.thirdTextField.text = self.web
            $0.thirdTextField.inputAccessoryView = accessoryCompleteButton
        }
        
        self.completeButton.do {
            $0.backgroundColor = .appColor(.mainColor)
            $0.setTitle("수정완료", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(completeModify), for: .touchUpInside)
        }
        self.accessoryCompleteButton.do {
            $0.setTitle("완료", for: .normal)
            $0.backgroundColor = UIColor.appColor(.mainColor)
            $0.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
            $0.addTarget(self, action: #selector(completeModify), for: .touchUpInside)
        }
    }
    
    func layout() {
        self.view.addSubview(snsModifyView)
        self.view.addSubview(completeButton)
        
        self.snsModifyView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                    constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        }
        
        self.completeButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        }
    }
    
    @objc func completeModify() {
        let github = snsModifyView.firstTextFeield.text ?? ""
        let linkedin = snsModifyView.secondTextField.text ?? ""
        let web = snsModifyView.thirdTextField.text ?? ""

        // 공백체크
        if github.whitespaceCheck()
            || linkedin.whitespaceCheck()
            || web.whitespaceCheck() {
            self.showToast(controller: self, message: "공백은 포함되지 않습니다.", seconds: 0.5)
        } else if !linkedin.linkedInCheck() {
            self.showToast(controller: self, message: "SNS 형식이 맞지 않습니다.", seconds: 0.5)
        } else if !web.webCheck() {
            self.showToast(controller: self, message: "SNS 형식이 맞지 않습니다.", seconds: 0.5)
        } else {
            showLoading()
            self.presenter?.completeModify(github: github, linkedin: linkedin, web: web)
        }
        
        print("씨다", linkedin.linkedInCheck())
    }
}

extension SNSModifyView: SNSModifyViewProtocol {
    func modifyResultHandle(result: Bool, message: String) {
        if result {
            let parent = self.navigationController?.viewControllers[1] as? ProfileDetailView
            self.navigationController?.popViewController(animated: true) {
                parent?.showToast(controller: parent!, message: "SNS 수정 완료", seconds: 1)
                parent?.presenter?.viewDidLoad()
            }
        } else {
            hideLoading()
            self.showToast(controller: self, message: message, seconds: 1, completion: nil)
        }
    }
    
    func showLoading() {
        LoadingRainbowCat.show(caller: self)
    }
    
    func hideLoading() {
        LoadingRainbowCat.hide(caller: self)
    }
}
