//
//  ProfileCell.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/06.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
    let profile = UIImageView()
    let name = UILabel()
    let descript = UILabel()
    let location = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    
    func attribute() {
        profile.do {
            $0.contentMode = .scaleAspectFill
            $0.image = #imageLiteral(resourceName: "leehi")
            $0.layer.cornerRadius = $0.frame.size.width/2
            $0.clipsToBounds = true
        }
        name.do {
            $0.text = "이하이"
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = $0.font.withSize(20)
        }
        descript.do {
            $0.text = "iOS를 공부하는 중입니다. 잘 부탁드립니다."
            $0.numberOfLines = 0
            $0.font = $0.font.withSize(16)
        }
        location.do {
            $0.text = "서울시 마포구"
            $0.font = $0.font.withSize(13)
        }
    }
    
    func layout() {
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
