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
        editMessageTextView.do {
            $0.dynamicFont(size: 10, weight: .regular)
            $0.delegate = self
            $0.backgroundColor = .systemGray5
            $0.layer.cornerRadius = 6
            $0.layer.masksToBounds = true
            $0.text = "허위 신고 시 이용이 제한될 수 있습니다."
            $0.textColor = .systemGray2
        }
    }
    
    override func layout() {
        super.layout()
        
        [bottomBar, reportTitleLabel, editMessageTextView].forEach { addSubview($0) }
        
        reportTitleLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: bottomBar.topAnchor,
                                    constant: Terminal.convertHeight(value: 20)).isActive = true
            $0.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        }
        editMessageTextView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: reportTitleLabel.bottomAnchor, constant: Terminal.convertHeight(value: 15)).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Terminal.convertWidth(value: 15)).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Terminal.convertWidth(value: 15)).isActive = true
            $0.bottomAnchor.constraint(equalTo: completeButton.topAnchor, constant: -Terminal.convertHeight(value: 15)).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AlertReportContentView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.dynamicFont(size: 12, weight: .regular)
        textView.textColor = .white
        textView.text = ""
    }
}
