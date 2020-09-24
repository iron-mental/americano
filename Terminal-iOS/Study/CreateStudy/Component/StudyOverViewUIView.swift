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
    var categoryLabel = UILabel()
    var textView = UITextView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    init(frame: CGRect, category: String) {
        super.init(frame: frame)
        seletedCategory = category
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
        categoryLabel.do {
            $0.text = seletedCategory
        }
        textView.do {
            $0.text = "test"
        }
    }
    
    func layout() {
        addSubview(titleLabel)
        addSubview(categoryLabel)
        addSubview(textView)
        
        titleLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
            $0.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: (18/170) * frame.size.height ).isActive = true
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
