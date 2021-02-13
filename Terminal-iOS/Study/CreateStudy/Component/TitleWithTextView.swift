//
//  StudyOverViewUIView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/20.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class TitleWithTextView: UIView {
    var seletedCategory: String?
    var titleLabel = UILabel()
    var title: String?
    var categoryLabel = UILabel()
    var textView = UITextView()
    
    init(title: String) {
        super.init(frame: .zero)
        self.title = title
        attribute()
        layout()
    }
    
    func attribute() {
        titleLabel.do {
            $0.text = title
            $0.backgroundColor = UIColor.appColor(.testColor)
            $0.dynamicFont(fontSize: $0.font.pointSize, weight: .medium)
        }
        categoryLabel.do {
            $0.textColor = .white
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.dynamicFont(fontSize: $0.font.pointSize, weight: .medium)
        }
        textView.do {
            $0.backgroundColor = UIColor.appColor(.InputViewColor)
            $0.layer.cornerRadius = 10
            $0.dynamicFont(size: 15, weight: .regular)
            $0.layer.borderWidth = 0.1
            $0.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    func layout() {
        [titleLabel, categoryLabel, textView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        titleLabel.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: topAnchor),
                $0.leadingAnchor.constraint(equalTo: leadingAnchor),
                $0.heightAnchor.constraint(equalToConstant: $0.intrinsicContentSize.height),
                $0.widthAnchor.constraint(equalToConstant: $0.intrinsicContentSize.width)
            ])
        }
        categoryLabel.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: titleLabel.topAnchor),
                $0.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
        }
        textView.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                        constant: Terminal.convertHeigt(value: 17)),
                $0.leadingAnchor.constraint(equalTo: leadingAnchor),
                $0.widthAnchor.constraint(equalTo: widthAnchor),
                $0.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
