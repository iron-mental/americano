//
//  ProfileSNSView.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/08.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class ProfileSNSView: BaseSNSView {
    
    let github = UIButton().then {
        $0.setImage(#imageLiteral(resourceName: "github"), for: .normal)
    }
    
    let linkedin = UIButton().then {
        $0.setImage(#imageLiteral(resourceName: "web"), for: .normal)
    }
    
    let web = UIButton().then {
        $0.setImage(#imageLiteral(resourceName: "blog"), for: .normal)
    }
    
    let modify = UIButton().then {
        $0.setTitle("수정", for: .normal)
        $0.setTitleColor(.appColor(.mainColor), for: .normal)
    }
    
    override func layout() {
        super.layout()
        self.addSubview(modify)
        
        self.modify.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
        }
    }
    
    override func addstack(snsList: [String : String]) {
        /// 추가된 SNS 갯수
        var count = 0
        
        if let _ = snsList["github"] {
            self.snsStack.addArrangedSubview(self.github)
                    count += 1
                }
        
        if let _ = snsList["linkedin"] {
            self.snsStack.addArrangedSubview(self.linkedin)
            count += 1
        }
        
        if let _ = snsList["web"] {
            self.snsStack.addArrangedSubview(self.web)
            count += 1
        }
        
        switch count {
        case 1:
            self.firstWidth.isActive = true
        case 2:
            self.secondWidth.isActive = true
        case 3:
            self.thirdWidth.isActive = true
        default:
            break
        }
    }
}
