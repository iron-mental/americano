//
//  SNSInputView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/20.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SNSInputView: UIView {
    var seletedCategory: String?
    var titleLabel = UILabel()
    var categoryLabel = UILabel()
    var textView = UITextView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.seletedCategory = "바꿔야할 부분"
        attribute()
        layout()
    }
    
    func attribute() {
        titleLabel.do {
            $0.text = "스터디 소개"
            $0.backgroundColor = .gray
            $0.textColor = .white
        }
        categoryLabel.do {
            $0.text = "야야야ㅑ야야야야야야야야"
            $0.backgroundColor = .gray
            $0.textColor = .white
        }
        textView.do {
            $0.text = "test"
            $0.backgroundColor = .green
        }
    }
    
    func layout() {
        addSubview(titleLabel)
        addSubview(categoryLabel)
        addSubview(textView)
        
        titleLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
            $0.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        }
        categoryLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
            $0.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        }
        textView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 300).isActive = true
            $0.topAnchor.constraint(equalTo: titleLabel.safeAreaLayoutGuide.bottomAnchor, constant: 30).isActive = true
            $0.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
