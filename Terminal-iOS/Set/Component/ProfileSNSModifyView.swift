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
        secondImage.do {
            $0.image = UIImage(named: "linkedin")
        }
        thirdImage.do {
            $0.image = UIImage(named: "web")
        }
    }
}
