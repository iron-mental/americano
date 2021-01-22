//
//  ProfileCell.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/06.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftKeychainWrapper

class ProfileCell: UITableViewCell {
    static let profileCellId = "profileCell"
    let profile = UIImageView(frame: CGRect(x: 0, y: 0,
                                            width: UIScreen.main.bounds.height * 0.1,
                                            height: UIScreen.main.bounds.height * 0.1))
    let name = UILabel()
    let descript = UILabel()
    let location = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        attribute()
        layout()
    }
    
    func setData(data: UserInfo) {
        let token = KeychainWrapper.standard.string(forKey: "accessToken")!
        /// Kingfisher auth token
        let imageDownloadRequest = AnyModifier { request in
            var requestBody = request
            requestBody.setValue("Bearer "+token, forHTTPHeaderField: "Authorization")
            return requestBody
        }
        
        
        /// 프로필 이미지
        let imageURL = data.image ?? ""
        self.profile.kf.setImage(with: URL(string: imageURL),
                                 options: [.requestModifier(imageDownloadRequest)])
        
        /// 자기소개
        self.name.text = data.nickname
        self.descript.text = data.introduce ?? ""
        
        /// 활동지역
        let sido = data.sido ?? ""
        let sigungu = data.sigungu ?? ""
        self.location.text = sido + " " + sigungu
    }
    
    func attribute() {
        self.backgroundColor = UIColor.appColor(.terminalBackground)
        profile.do {
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = $0.frame.size.width/2
            $0.clipsToBounds = true
        }
        name.do {
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = $0.font.withSize(20)
        }
        descript.do {
            $0.numberOfLines = 0
            $0.font = $0.font.withSize(16)
        }
        location.do {
            $0.font = $0.font.withSize(13)
        }
    }
    
    func layout() {
        [profile, name, descript, location].forEach{ self.contentView.addSubview($0)}
        
        self.profile.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
            $0.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.1).isActive = true
            $0.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.1).isActive = true
        }
        self.name.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: profile.trailingAnchor, constant: 20).isActive = true
        }
        self.descript.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: profile.trailingAnchor, constant: 20).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -3).isActive = true
        }
        self.location.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
