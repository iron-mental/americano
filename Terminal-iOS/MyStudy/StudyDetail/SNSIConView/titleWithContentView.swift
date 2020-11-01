//
//  StudyIntroduceLabel.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class titleWithContentView: UIView {
    var title = UILabel()
    var content = UILabel()
    
    init() {
        super.init(frame: CGRect.zero)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attribute() {
        title.do {
            $0.font = UIFont.boldSystemFont(ofSize: 16)
            $0.text = "기본타이틀"
        }
        content.do {
            $0.text = "안녕하세요 Swift를 정복하기 위한\n스터디에 함께 할 분을 모집중입니다.\n열심히 하실 분이라면 언제든 환영합니다.\n위의 노션링크도 참고해주세요"
            $0.font.withSize(16)
            $0.numberOfLines = 0
            $0.setLineSpacing(lineSpacing: 13, lineHeightMultiple: 0)
        }
    }
    
    func layout() {
        [title, content].forEach { addSubview($0) }
        
        title.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: title.intrinsicContentSize.height).isActive = true
        }
        content.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: title.bottomAnchor, constant: Terminal.convertHeigt(value: 3)).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: content.intrinsicContentSize.height).isActive = true
        }
    }
    func titleHidden() {
        title.isHidden = true
        
        content.do {
            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: content.intrinsicContentSize.height).isActive = true
        }
    }
}
