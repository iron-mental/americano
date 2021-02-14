//
//  ProejctSNSView.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/05.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

final class ProjectSNSModifyView: BaseSNSModifyView {
    override func attribute() {
        super.attribute()
        
        firstImage.do {
            $0.image = #imageLiteral(resourceName: "github")
        }
        firstTextFeield.do {
            $0.placeholder = "user ID만 입력"
        }
        secondImage.do {
            $0.image = #imageLiteral(resourceName: "app-store")
        }
        secondTextField.do {
            $0.placeholder = "URL 전체 입력"
        }
        thirdImage.do {
            $0.image = #imageLiteral(resourceName: "playstore")
        }
        thirdTextField.do {
            $0.placeholder = "URL 전체 입력"
        }
    }
}
