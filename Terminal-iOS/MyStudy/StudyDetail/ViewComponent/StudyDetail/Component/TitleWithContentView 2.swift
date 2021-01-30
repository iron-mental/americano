//
//  StudyIntroduceLabel.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class TitleWithContentView: UIView {
    var title = UILabel()
    var label = UILabel()
    var state: StudyDetailViewState = .none
    var contentText: [String] = ["기본 제목", "기본 텍스트"] {
        didSet {
            attribute()
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        attribute()
        labelLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attribute() {
        self.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        title.do {
            $0.font = UIFont.boldSystemFont(ofSize: 18)
            $0.text = contentText[0]
        }
        label.do {
            $0.font.withSize(16)
            $0.numberOfLines = 0
            $0.text = contentText[1]
            $0.setLineSpacing(lineSpacing: 13, lineHeightMultiple: 0)
            $0.setMargins()
            $0.backgroundColor = UIColor.appColor(.InputViewColor)
            $0.sizeToFit()
            let insets = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
            $0.frame.inset(by: insets)
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
        }
    }
    
    func labelLayout() {
        [title, label ].forEach { addSubview($0) }
        
        label.isHidden = false
        
        title.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: title.intrinsicContentSize.height).isActive = true
        }
        label.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: title.bottomAnchor, constant: Terminal.convertHeigt(value: 10)).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
//            $0.heightAnchor.constraint(equalToConstant: label.intrinsicContentSize.height + 40).isActive = true
        }
    }
    
    func titleHidden() {
        title.isHidden = true
        if self.state == .edit{
        } else {
            label.do {
                $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
                $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
                $0.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
                $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 45)).isActive = true
            }
        }
    }
}
