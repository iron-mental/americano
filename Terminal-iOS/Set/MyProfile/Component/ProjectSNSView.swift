//
//  ProjectSNSView.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/08.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

final class ProjectSNSView: BaseSNSView {
    let github = UIButton().then {
        $0.setImage(#imageLiteral(resourceName: "github"), for: .normal)
        $0.accessibilityIdentifier = "github"
    }
    let appStore = UIButton().then {
        $0.setImage(#imageLiteral(resourceName: "app-store"), for: .normal)
        $0.accessibilityIdentifier = "appStore"
    }
    let playStore = UIButton().then {
        $0.setImage(#imageLiteral(resourceName: "playstore"), for: .normal)
        $0.accessibilityIdentifier = "playStore"
    }
    
    override func addstack(snsList: [String: String]) {
        self.snsStack.removeAllArrangedSubviews()
        
        if snsList["github"]!.isEmpty {
            self.github.alpha = 0.3
        }
        
        if snsList["appStore"]!.isEmpty {
            self.appStore.alpha = 0.3
        }
        
        if snsList["playStore"]!.isEmpty {
            self.playStore.alpha = 0.3
        }
        
        self.snsStack.addArrangedSubview(self.github)
        self.snsStack.addArrangedSubview(self.appStore)
        self.snsStack.addArrangedSubview(self.playStore)
        
        self.thirdWidth.isActive = true
    }
}
