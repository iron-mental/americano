//
//  StudyApplyMessageView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/08.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

enum StudyApplyMessageType {
    case apply
    case modify
}

class StudyApplyMessageView: AlertBaseUIView {
    var type: StudyApplyMessageType = .apply
    var applyTitleLabel = UILabel()
    var applyGuideLabel = UILabel()
    var editMessageTextField = UITextField()
    
    init(type: StudyApplyMessageType) {
        super.init()
        self.type = type
        super.attribute()
        attribute()
        layout()
    }
    
    override func attribute() {
        super.attribute()
        applyTitleLabel.do {
            $0.dynamicFont(fontSize: 15, weight: .bold)
            $0.text = type == .apply ? "스터디 신청하기" : "신청 메세지 수정하기"
        }
        applyGuideLabel.do {
            $0.dynamicFont(fontSize: 13, weight: .bold)
            $0.text = type == .apply ? "가입 인사를 작성해보세요" : "수정할 메세지를 작성하세요"
        }
        editMessageTextField.do {
            $0.dynamicFont(fontSize: 13, weight: .regular)
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
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Terminal.convertWidth(value: 20)).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
