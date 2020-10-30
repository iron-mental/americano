//
//  MemberCollectionViewCell.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class MemberCollectionViewCell: UICollectionViewCell {
    static  let identifier = "cell"
    var profileImage = UIImageView()
    var ranking =  UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    func attribute() {
    }
    
    func layout() {
        addSubview(profileImage)
        addSubview(ranking)
        
//        profileImage.snp.makeConstraints {
//            $0.top.centerX.equalToSuperview()
//            $0.width.height.equalTo(MannaDemo.convertWidth(value: 43))
//        }
//        ranking.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.top.equalTo(profileImage.snp.bottom)
//            $0.width.height.equalTo(MannaDemo.convertWidth(value: 27))
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
