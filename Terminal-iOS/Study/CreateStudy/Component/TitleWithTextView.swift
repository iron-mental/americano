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
    var textView = UITextView()
    
    init(frame: CGRect,title: String) {
        super.init(frame: frame)
        self.title = title
        attribute()
        layout()
    }
    
    func attribute() {
        self.do {
            $0.backgroundColor = .white
        }
        titleLabel.do {
            $0.text = title
        }
        textView.do {
            $0.text = "test"
            $0.backgroundColor = UIColor.appColor(.InputViewColor)
            $0.layer.cornerRadius = 10
        }
    }
    
    func layout() {
        addSubview(titleLabel)
        addSubview(textView)

        titleLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (18/117) * frame.height).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (76/352) * frame.width).isActive = true
        }
        textView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: (18/117) * frame.height).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (117/151) * frame.height).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
