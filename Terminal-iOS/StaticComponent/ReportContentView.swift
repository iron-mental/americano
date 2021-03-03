//
//  ReportContentView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/03/03.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class ReportContentView: AlertBaseUIView {
    var reportTitleLabel = UILabel()
    var editMessageTextField = UITextField()
    
    init(type: StudyApplyMessageType) {
        super.init()
        attribute()
        layout()
    }
    
    override func attribute() {
        super.attribute()
        reportTitleLabel.do {
            $0.dynamicFont(fontSize: 15, weight: .bold)
            $0.text = "신고내용을 기재해주세요."
        }
        editMessageTextField.do {
            $0.dynamicFont(fontSize: 13, weight: .regular)
            $0.placeholder = "허위 신고 시 이용이 제한될 수 있습니다."
        }
    }
    
    override func layout() {
        super.layout()
        
        [bottomBar, reportTitleLabel, editMessageTextField].forEach { addSubview($0) }
        
        reportTitleLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: bottomBar.topAnchor, constant: 8).isActive = true
            $0.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
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
