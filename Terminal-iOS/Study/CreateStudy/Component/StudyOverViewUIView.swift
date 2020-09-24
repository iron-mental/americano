//
//  SNSInputView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/20.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class StudyOverViewUIView: UIView {
    var seletedCategory: String?
    var titleLabel = UILabel()
    var textView = UITextView()
    var screensize = UIScreen.main.bounds
    init() {
        super.init(frame: CGRect.zero)
        attribute()
        layout()
    }
    
    func attribute() {
        self.do {
            $0.backgroundColor = .white
        }
        titleLabel.do {
            $0.text = "스터디 소개"
        }
        textView.do {
            $0.text = "test"
        }
    }
    
    func layout() {
        addSubview(titleLabel)
        addSubview(textView)

        titleLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
            
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (16 / 667) * screensize.height).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (76/375) * screensize.width).isActive = true
        }
        textView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: (18/667) * screensize.height).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (117/667) * screensize.height).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
