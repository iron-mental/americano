//
//  FindPasswordView.swift
//  Terminal-iOS
//
//  Created by once on 2021/02/26.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit
import Then

final class FindPasswordView: UIViewController {
    var presenter: FindPasswordPresenterProtocol?
    
    let backButton = UIButton()
    let descript = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        self.do {
            $0.view.backgroundColor = .appColor(.terminalBackground)
        }
        self.backButton.do {
            $0.setImage(#imageLiteral(resourceName: "close"), for: .normal)
            $0.addTarget(self, action: #selector(back), for: .touchUpInside)
        }
        self.descript.do {
            $0.text = "터미널에서 가입했던 이메일을 입력해주세요.\n비밀번호 재설정 메일을 보내드립니다."
            $0.font = .notosansMedium(size: 15)
            $0.textColor = .white
            $0.textAlignment = .center
            $0.numberOfLines = 2
        }
    }
    
    func layout() {
        [backButton, descript].forEach { self.view.addSubview($0) }
        
        self.backButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                    constant: Terminal.convertWidth(value: 18)).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                        constant: Terminal.convertWidth(value: 18)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 18)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 18)).isActive = true
        }
        self.descript.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                    constant: Terminal.convertHeight(value: 100)).isActive = true
            $0.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        }
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension FindPasswordView: FindPasswordViewProtocol {
        
}
