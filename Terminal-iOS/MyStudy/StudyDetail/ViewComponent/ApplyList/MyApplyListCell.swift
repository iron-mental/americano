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
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
        }
    }
    func setData(studies: ApplyStudy) {
        if let imageURL = studies.image {
            
            if imageURL.isEmpty {
                //이미지가 ""일때
                mainImage.layer.addSublayer(borderLayer)
                mainImage.image = nil
                borderLayer.path = UIBezierPath(rect: CGRect(x: 0,
                                                             y: 0,
                                                             width: mainImage.constraints[0].constant,
                                                             height: mainImage.constraints[1].constant)).cgPath
                borderLayer.frame = CGRect(x: 0,
                                           y: 0,
                                           width: mainImage.constraints[0].constant,
                                           height: mainImage.constraints[1].constant)
            } else {
                //이미지가 유효할 때
                borderLayer.removeFromSuperlayer()
                self.mainImage.kf.setImage(with: URL(string: imageURL), options: [.requestModifier(RequestToken.token())])
            }
        } else {
            //이미지가 nil일 때
            mainImage.layer.addSublayer(borderLayer)
            mainImage.image = nil
            borderLayer.path = UIBezierPath(rect: CGRect(x: 0,
                                                         y: 0,
                                                         width: mainImage.frame.width,
                                                         height: mainImage.frame.height)).cgPath
            borderLayer.frame = CGRect(x: 0,
                                       y: 0,
                                       width: mainImage.frame.width,
                                       height: mainImage.frame.height)
        }
        
        self.title.text = studies.title
        self.contents.text = studies.message
    }
}
