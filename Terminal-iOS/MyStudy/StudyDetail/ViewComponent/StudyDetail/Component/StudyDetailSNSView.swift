//
//  StudyDetailSNSView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/31.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

final class StudyDetailSNSView: BaseSNSView {
    let notion = UIButton().then {
        $0.setImage(#imageLiteral(resourceName: "notion"), for: .normal)
        $0.tag = 0
    }
    let evernote = UIButton().then {
        $0.setImage(#imageLiteral(resourceName: "evernote"), for: .normal)
        $0.tag = 1
    }
    let web = UIButton().then {
        $0.setImage(#imageLiteral(resourceName: "web"), for: .normal)
        $0.tag = 2
    }
    let modify = UIButton().then {
        $0.setTitle("수정", for: .normal)
        $0.setTitleColor(.appColor(.mainColor), for: .normal)
    }
    
    override func layout() {
        super.layout()
    }
    
    override func addstack(snsList: [String: String]) {
        /// 추가된 SNS 갯수
        self.snsStack.removeAllArrangedSubviews()
        
        if snsList["notion"]!.isEmpty {
            self.notion.setImage(#imageLiteral(resourceName: "disablednotion"), for: .normal)
            self.notion.isUserInteractionEnabled = false
        }
        if snsList["evernote"]!.isEmpty {
            self.evernote.setImage(#imageLiteral(resourceName: "disabledevernote"), for: .normal)
            self.evernote.isUserInteractionEnabled = false
        }
        if snsList["web"]!.isEmpty {
            self.web.setImage(#imageLiteral(resourceName: "disabledweb"), for: .normal)
            self.web.isUserInteractionEnabled = false
        }
        
        self.snsStack.addArrangedSubview(self.notion)
        self.snsStack.addArrangedSubview(self.evernote)
        self.snsStack.addArrangedSubview(self.web)
        
        self.firstWidth.isActive = false
        self.secondWidth.isActive = false
        self.thirdWidth.isActive = true
    }
}
