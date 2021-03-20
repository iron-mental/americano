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
    var label = PaddingLabel()
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
            $0.dynamicFont(fontSize: 16, weight: .bold)
            $0.text = contentText[0]
        }
        label.do {
            $0.numberOfLines = 0
            $0.text = contentText[1]
            $0.setMargins(margin: 10)
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
            $0.topAnchor.constraint(equalTo: title.bottomAnchor, constant: Terminal.convertHeight(value: 10)).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        }
    }
}
