//
//  StudyApplyMessageView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/08.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit


class StudyApplyMessageView: TerminalAlertUIView {
    var applyGuideLabel = UILabel()
    
    override init() {
        super.init()
        attribute()
        layout()
    }
    override func attribute() {
        applyGuideLabel.do {
            $0.text = "스터디 신청하기"
            $0.textColor = UIColor.appColor(.alertTextcolor)
            $0.font = UIFont.monospacedSystemFont(ofSize: $0.font.pointSize + 5, weight: UIFont.Weight.regular)
        }
    }
    override func layout() {
        [applyGuideLabel].forEach { addSubview($0) }
        
        applyGuideLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: bottomBar.topAnchor, constant: 8).isActive = true
            $0.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
