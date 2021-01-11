//
//  StudyApplyMessageView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/08.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit


class StudyApplyMessageView: TerminalAlertUIView {
    var applyTitleLabel = UILabel()
    var applyGuideLabel = UILabel()
    var editMessageTextField = UITextField()
    
    override init() {
        super.init()
        super.attribute()
        attribute()
        layout()
    }
    override func attribute() {
        super.attribute()
        applyTitleLabel.do {
            $0.text = "스터디 신청하기"
            $0.font = UIFont.monospacedSystemFont(ofSize: $0.font.pointSize + 5, weight: UIFont.Weight.regular)
        }
        applyGuideLabel.do {
            $0.text = "가입 인사를 작성해보세요"
            $0.font = UIFont.monospacedSystemFont(ofSize: $0.font.pointSize, weight: UIFont.Weight.regular)
        }
        editMessageTextField.do {
            $0.placeholder = "스터디 참여를 희망합니다."
        }
    }
    override func layout() {
        super.layout()
        
        [bottomBar, applyTitleLabel, applyGuideLabel, editMessageTextField].forEach { addSubview($0) }
        
        applyTitleLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: bottomBar.topAnchor, constant: 8).isActive = true
            $0.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        }
        applyGuideLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Terminal.convertWidth(value: 20)).isActive = true
            $0.topAnchor.constraint(equalTo: applyTitleLabel.bottomAnchor, constant: 16).isActive = true
        }
        editMessageTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Terminal.convertWidth(value: 20)).isActive = true
            $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
