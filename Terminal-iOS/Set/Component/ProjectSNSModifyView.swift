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
            $0.image = UIImage(named: "github")
        }
        secondImage.do {
            $0.image = UIImage(named: "app-store")
        }
        thirdImage.do {
            $0.image = UIImage(named: "playstore")
        }
    }
}
