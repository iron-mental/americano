//
//  FindPasswordResultView.swift
//  Terminal-iOS
//
//  Created by once on 2021/02/26.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

final class FindPasswordResultView: UIViewController {
    let backButton = UIButton()
    let mailImage = UIImageView()
    let confirmEmail = UILabel()
    let descript = UILabel()
    let completeButton = UIButton()
    
    var email: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    private func attribute() {
        self.do {
            $0.view.backgroundColor = .appColor(.terminalBackground)
        }
        self.backButton.do {
            $0.setImage(#imageLiteral(resourceName: "close"), for: .normal)
            $0.addTarget(self, action: #selector(complete), for: .touchUpInside)
        }
        self.mailImage.do {
            $0.image = UIImage(systemName: "envelope")?.withConfiguration(UIImage.SymbolConfiguration(weight: .light))
            $0.tintColor = .white
        }
        self.confirmEmail.do {
            $0.text = self.email ?? ""
            $0.font = .notosansMedium(size: 25)
            $0.textColor = .appColor(.mainColor)
            $0.textAlignment = .center
            $0.numberOfLines = 2
        }
        self.descript.do {
            $0.text = "해당 이메일로 요청이 전송되었습니다."
            $0.font = .notosansMedium(size: 15)
            $0.textColor = .white
            $0.textAlignment = .center
            $0.numberOfLines = 0
        }
        self.completeButton.do {
            $0.setTitle("완료", for: .normal)
            $0.titleLabel?.font = .notosansMedium(size: 15)
            $0.backgroundColor = .appColor(.mainColor)
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(complete), for: .touchUpInside)
        }
    }
    
    private func layout() {
        [backButton, mailImage, confirmEmail, descript, completeButton].forEach { self.view.addSubview($0) }
        
        self.backButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                    constant: Terminal.convertWidth(value: 18)).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                        constant: Terminal.convertWidth(value: 18)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 18)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 18)).isActive = true
        }
        self.mailImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                    constant: Terminal.convertHeight(value: 130)).isActive = true
            $0.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: self.view.frame.width / 2).isActive = true
            $0.heightAnchor.constraint(equalToConstant: self.view.frame.width / 3).isActive = true
        }
        self.confirmEmail.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.mailImage.bottomAnchor,
                                    constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                        constant: Terminal.convertWidth(value: 18)).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                        constant: Terminal.convertWidth(value: -18)).isActive = true
        }
        self.descript.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.confirmEmail.bottomAnchor,
                                    constant: 10).isActive = true
            $0.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        }
        self.completeButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                                       constant: -10).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                        constant: Terminal.convertWidth(value: 18)).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                        constant: Terminal.convertWidth(value: -18)).isActive = true
        }
    }
    
    @objc func complete() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
