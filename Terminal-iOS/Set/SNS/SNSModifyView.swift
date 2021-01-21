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
    
    lazy var snsModifyView =
        ProfileSNSModifyView()
    lazy var completeButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }

    func attribute() {
        self.view.backgroundColor = .appColor(.terminalBackground)

        self.snsModifyView.firstTextFeield.text = self.github
        self.snsModifyView.secondTextField.text = self.linkedin
        self.snsModifyView.thirdTextField.text = self.web
        
        self.completeButton.do {
            $0.backgroundColor = .appColor(.mainColor)
            $0.setTitle("수정완료", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 10
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
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        }
        
        self.completeButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.snsModifyView.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 60).isActive = true
        }
    }
    
    @objc func completeModify() {
        let github = snsModifyView.firstTextFeield.text ?? ""
        let linkedIn = snsModifyView.secondTextField.text ?? ""
        let web = snsModifyView.thirdTextField.text ?? ""

        self.presenter?.completeModify(github: github, linkedIn: linkedIn, web: web)
    }
}

extension SNSModifyView: SNSModifyViewProtocol {
    func modifyResultHandle(result: Bool, message: String) {
        if result {
            let parent = self.navigationController?.viewControllers[1] as? ProfileDetailView
            self.navigationController?.popViewController(animated: true, completion: {
                parent?.showToast(controller: parent!, message: "SNS 수정 완료", seconds: 1)
                parent?.presenter?.viewDidLoad()
            })
        } else {
            print("message",message)
        }
    }
}
