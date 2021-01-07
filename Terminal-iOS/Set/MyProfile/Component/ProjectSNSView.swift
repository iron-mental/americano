//
//  ProjectSNSView.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/08.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class ProjectSNSView: BaseSNSView {
    let github = UIButton().then {
        $0.setImage(#imageLiteral(resourceName: "github"), for: .normal)
    }
    let appStore = UIButton().then {
        $0.setImage(#imageLiteral(resourceName: "app-store"), for: .normal)
    }
    let playStore = UIButton().then {
        $0.setImage(#imageLiteral(resourceName: "playstore"), for: .normal)
    }
    
    override func addstack(snsList: [String : String]) {
        /// 추가된 SNS 갯수
        var count = 0
        
        if let _ = snsList["github"] {
            self.snsStack.addArrangedSubview(self.github)
                    count += 1
                }
        
        if let _ = snsList["appStore"] {
            self.snsStack.addArrangedSubview(self.appStore)
            count += 1
        }
        
        if let _ = snsList["playStore"] {
            self.snsStack.addArrangedSubview(self.playStore)
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
