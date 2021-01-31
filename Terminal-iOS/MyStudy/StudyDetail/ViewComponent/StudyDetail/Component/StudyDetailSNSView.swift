//
//  StudyDetailSNSView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/31.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class StudyDetailSNSView: BaseSNSView {
    let notion = UIButton().then {
        $0.setImage(#imageLiteral(resourceName: "swiftmain"), for: .normal)
    }
    
    let evernote = UIButton().then {
        $0.setImage(#imageLiteral(resourceName: "evernote"), for: .normal)
    }
    
    let web = UIButton().then {
        $0.setImage(#imageLiteral(resourceName: "web"), for: .normal)
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
        var count = 0
        
        self.snsStack.removeAllArrangedSubviews()
        
        if snsList["notion"] != nil {
            self.snsStack.addArrangedSubview(self.notion)
            count += 1
        }
        
        if snsList["evernote"] != nil {
            self.snsStack.addArrangedSubview(self.evernote)
            count += 1
        }
        
        if snsList["web"] != nil {
            self.snsStack.addArrangedSubview(self.web)
            count += 1
        }
        
        switch count {
        case 1:
            self.firstWidth.isActive = true
            self.secondWidth.isActive = false
            self.thirdWidth.isActive = false
        case 2:
            self.firstWidth.isActive = false
            self.secondWidth.isActive = true
            self.thirdWidth.isActive = false
        case 3:
            self.firstWidth.isActive = false
            self.secondWidth.isActive = false
            self.thirdWidth.isActive = true
        default:
            break
        }
    }
}
