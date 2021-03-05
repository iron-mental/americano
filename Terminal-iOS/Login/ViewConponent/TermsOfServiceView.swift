//
//  TermsOfServiceView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/03/05.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class TermsOfServiceView: UIView {
    var guideLabel = UILabel()
    let text = "회원가입시 개인정보 처리방침과\n이용약관에 동의하신 것으로 간주합니다."
    var termsRange: NSRange?
    var privacyRange: NSRange?
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    func attribute() {
        let underlineAttriString = NSMutableAttributedString(string: text)
        termsRange = (text as NSString).range(of: "이용약관")
        privacyRange = (text as NSString).range(of: "개인정보 처리방침")
        underlineAttriString.do {
            $0.addAttribute(NSAttributedString.Key.foregroundColor,
                            value: UIColor.appColor(.mainColor), range: termsRange!)
            $0.addAttribute(NSAttributedString.Key.foregroundColor,
                            value: UIColor.appColor(.mainColor), range: privacyRange!)
        }
        guideLabel.do {
            $0.text = text
            $0.numberOfLines = 2
            $0.textAlignment = .center
            $0.dynamicFont(fontSize: 11, weight: .regular)
            $0.textColor =  UIColor.gray
            $0.attributedText = underlineAttriString
            $0.isUserInteractionEnabled = true
        }
    }
    
    func layout() {
        addSubview(guideLabel)
        
        guideLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
