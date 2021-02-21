//
//  MyApplyListCell.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper
import Kingfisher

class MyApplyListCell: ApplyListCell {
    static let myApplyListCellID = "MyApplyListCell"
    
    override func attribute() {
        super.attribute()
        self.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.selectionStyle = .none
        }
        self.mainImage.do {
            $0.layer.cornerRadius = 20
            $0.layer.masksToBounds = true
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
        }
    }
    func setData(studies: ApplyStudy) {
        if let imageURL = studies.image {
            self.mainImage.kf.setImage(with: URL(string: imageURL), options: [.requestModifier(RequestToken.token())])
        }
        
        self.title.text = studies.title
        self.contents.text = studies.message
    }
}
