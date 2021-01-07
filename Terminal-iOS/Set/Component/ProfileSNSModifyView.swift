//
//  ProfileSNSView.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/05.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

final class ProfileSNSModifyView: SNSModifyView {
    
    override func attribute() {
        super.attribute()
        firstImage.do {
            $0.image = UIImage(named: "github")
        }
        firstTextFeield.do {
            $0.placeholder = "Github ID"
        }
        secondImage.do {
            $0.image = UIImage(named: "linkedin")
        }
        secondTextField.do {
            $0.placeholder = "LinkedIn URL"
        }
        thirdImage.do {
            $0.image = UIImage(named: "web")
        }
        thirdTextField.do {
            $0.placeholder = "URL"
        }
    }
}
