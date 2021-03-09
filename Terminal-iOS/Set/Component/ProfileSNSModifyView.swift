//
//  ProfileSNSModifyView.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/08.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

final class ProfileSNSModifyView: BaseSNSModifyView {
    override func attribute() {
        super.attribute()
        
        firstImage.do {
            $0.image = UIImage(named: "github")
        }
        firstTextFeield.do {
            $0.placeholder = "user ID만 입력"
        }
        secondImage.do {
            $0.image = UIImage(named: "linkedin")
        }
        secondTextField.do {
            $0.placeholder = "URL 전체 입력"
        }
        thirdImage.do {
            $0.image = UIImage(named: "web")
        }
        thirdTextField.do {
            $0.placeholder = "URL 전체 입력"
        }
    }
}
