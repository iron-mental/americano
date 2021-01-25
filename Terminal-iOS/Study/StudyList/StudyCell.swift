//
//  StudyCell.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Then
import Kingfisher

class StudyCell: UITableViewCell {
    static let cellId = "cellId"
    
    var mainTitle = UILabel()
    let location = UILabel()
    let date = UILabel()
    let managerImage = UIImageView()
    let mainImage = UIImageView()
    let memberImage = UIImageView()
    let memberCount = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }

    override func prepareForReuse() {
        self.mainTitle.text = nil
        self.location.text = nil
        self.date.text = nil
        self.managerImage.image = nil
        self.mainImage.image = nil
    }
    
    func setData(_ data: Study) {
        let token = KeychainWrapper.standard.string(forKey: "accessToken")!
        let imageDownloadRequest = AnyModifier { request in
            var requestBody = request
            requestBody.setValue("Bearer "+token, forHTTPHeaderField: "Authorization")
            return requestBody
        }
        
        self.mainTitle.do {
            $0.text = data.title
        }
        self.location.do {
            $0.text = data.sigungu
        }
        
        self.date.do {
            $0.text = data.createdAt
        }
        self.memberCount.do {
//            $0.text = "\(data.members!)"
            $0.text = "10명"
        }
        guard let main = data.image else {
            mainImage.image = #imageLiteral(resourceName: "swiftmain")
            return
        }
        guard let leader = data.leaderImage else {
            managerImage.image = #imageLiteral(resourceName: "leehi")
            return
        }
        
        let processor = DownsamplingImageProcessor(size: mainImage.bounds.size)
        self.mainImage.kf.indicatorType = .activity
        self.mainImage.kf.setImage(
            with: URL(string: main),
            options: [.requestModifier(imageDownloadRequest),
                      .processor(processor),
                      .scaleFactor(UIScreen.main.scale),
                      .cacheOriginalImage
            ])
        
        self.managerImage.kf.setImage(with: URL(string: leader), options: [.requestModifier(imageDownloadRequest)])
    }
    
    func attribute() {
        self.backgroundColor = UIColor.appColor(.terminalBackground)
        
        self.mainTitle.do {
            $0.font = UIFont(name: "NotoSansKR-Medium", size: 20)
            $0.textColor = .white
        }
        self.location.do {
            $0.textColor = UIColor.appColor(.mainColor)
            $0.font = UIFont(name: "NotoSansKR-Medium", size: 13)
            $0.textAlignment = .center
            $0.sizeToFit()
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 7
        }
        self.date.do {
            $0.font = UIFont(name: "NotoSansKR-Medium", size: 13)
            $0.textColor = UIColor.appColor(.studySubTitle)
        }
        self.managerImage.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10
        }
        self.memberImage.do {
            $0.image = UIImage(named: "member")
        }
        self.memberCount.do {
            $0.textColor = .white
            $0.font = UIFont.notosansMedium(size: 15)
            $0.textAlignment = .center
        }
    }
    
    func layout() {
        [mainTitle, date, managerImage, mainImage, location, memberImage, memberCount]
            .forEach { self.contentView.addSubview($0) }
       
        self.location.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 22).isActive = true
        }
        self.mainTitle.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.location.bottomAnchor, constant: 8).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.mainImage.leadingAnchor, constant: -10).isActive = true
        }
        self.date.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.mainTitle.bottomAnchor, constant: 8).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        }
        self.managerImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: self.date.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.date.trailingAnchor, constant: 10).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 20).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 20).isActive = true
        }
        self.mainImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 112).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        }
        self.memberImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.memberCount.leadingAnchor, constant: -3).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 25).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 25).isActive = true
        }
        self.memberCount.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.mainImage.leadingAnchor, constant: -5).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
