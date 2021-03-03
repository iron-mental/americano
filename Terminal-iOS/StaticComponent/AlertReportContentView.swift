//
//  ReportContentView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/03/03.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class AlertReportContentView: AlertBaseUIView {
    var reportTitleLabel = UILabel()
    var reportGuideLabel = UILabel()
    var editMessageTextView = UITextView()
    
    override init() {
        super.init()
        attribute()
        layout()
    }
    
    override func attribute() {
        super.attribute()
        reportTitleLabel.do {
            $0.dynamicFont(fontSize: 13, weight: .bold)
            $0.text = "📢 신고내용을 기재해주세요."
        }
        reportGuideLabel.do {
            $0.dynamicFont(fontSize: 10, weight: .regular)
            $0.textColor = UIColor.systemGray2
            $0.text = "허위 신고 시 이용이 제한될 수 있습니다."
        }
        editMessageTextView.do {
            $0.dynamicFont(size: 11, weight: .regular)
            $0.delegate = self
            $0.backgroundColor = .systemGray5
            $0.layer.cornerRadius = 6
            $0.layer.masksToBounds = true
        }
    }
    
    override func layout() {
        super.layout()
        
        [bottomBar, reportTitleLabel, reportGuideLabel, editMessageTextView].forEach { addSubview($0) }
        
        reportTitleLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: bottomBar.topAnchor,
                                    constant: Terminal.convertHeight(value: 20)).isActive = true
            $0.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        }
        reportGuideLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: reportTitleLabel.bottomAnchor,
                                    constant: Terminal.convertHeight(value: 5)).isActive = true
            $0.centerXAnchor.constraint(equalTo: bottomBar.centerXAnchor).isActive = true
            
        }
        editMessageTextView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: bottomBar.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Terminal.convertWidth(value: 20)).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Terminal.convertWidth(value: 20)).isActive = true
            $0.bottomAnchor.constraint(equalTo: bottomBar.bottomAnchor, constant: -Terminal.convertHeight(value: 15)).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AlertReportContentView: UITextViewDelegate {
    
}
