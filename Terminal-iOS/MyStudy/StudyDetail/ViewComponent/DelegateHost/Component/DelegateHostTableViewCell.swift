//
//  DelegateHostTableViewCell.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/22.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftKeychainWrapper

class DelegateHostTableViewCell: UITableViewCell {
    static let id = "DelegateHostTableViewCell"
    var profileImage = UIImageView()
    var nickname = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    func attribute() {
        self.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        profileImage.do {
            $0.layer.cornerRadius = Terminal.convertWidth(value: 46) / 2
            $0.layer.masksToBounds = true
            $0.contentMode = .scaleAspectFill
            $0.layer.borderWidth = 0.3
            $0.layer.borderColor = UIColor.lightGray.cgColor
        }
        nickname.do {
            $0.dynamicFont(fontSize: 15, weight: .bold)
        }
    }
    
    func layout() {
        [ profileImage, nickname ].forEach { addSubview($0) }
        
        profileImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Terminal.convertWidth(value: 10)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 46)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 46)).isActive = true
            $0.topAnchor.constraint(equalTo: topAnchor, constant: Terminal.convertWidth(value: 10)).isActive = true
        }
        nickname.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: Terminal.convertWidth(value: 30)).isActive = true
        }
    }
    
    func setData(data: Participate) {
        let token = KeychainWrapper.standard.string(forKey: "accessToken")!
        let imageDownloadRequest = AnyModifier { request in
            var requestBody = request
            requestBody.setValue("Bearer "+token, forHTTPHeaderField: "Authorization")
            return requestBody
        }
        
        if let imageURL = data.image {
            self.profileImage.kf.setImage(with: URL(string: imageURL), options: [.requestModifier(imageDownloadRequest)])
        } else {
            self.profileImage.image = #imageLiteral(resourceName: "defaultProfile")
        }
        nickname.text = data.nickname
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
