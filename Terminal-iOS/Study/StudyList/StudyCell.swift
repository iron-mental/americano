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
    let subTitle = UILabel()
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
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        mainTitle.text = nil
        subTitle.text = nil
        location.text = nil
        date.text = nil
        managerImage.image = nil
        mainImage.image = nil
    }
    
    func setData(_ data: Study) {
        let token = KeychainWrapper.standard.string(forKey: "accessToken")!
        let imageDownloadRequest = AnyModifier { request in
            var requestBody = request
            requestBody.setValue("Bearer "+token, forHTTPHeaderField: "Authorization")
            return requestBody
        }
        
        mainTitle.do {
            $0.text = data.title
        }
        
        subTitle.do {
            $0.text = data.introduce
        }
        
        location.do {
            $0.text = data.sigungu
        }
        
        date.do {
            $0.text = data.createdAt
        }
        memberCount.do {
//            $0.text = "\(data.members!)"
            $0.text = "이거 뭐임"
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
        mainTitle.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        
        self.backgroundColor = UIColor.appColor(.terminalBackground)
        mainTitle.do {
            $0.font = UIFont(name: "NotoSansKR-Medium", size: 20)
            $0.textColor = .white
        }
        subTitle.do {
            $0.font = UIFont(name: "NotoSansKR-Medium", size: 13)
            $0.textColor = UIColor.appColor(.studySubTitle)
        }
        location.do {
            $0.backgroundColor = UIColor.appColor(.mainColor)
            $0.textColor = .white
            $0.font = UIFont(name: "NotoSansKR-Medium", size: 13)
            $0.textAlignment = .center
            $0.sizeToFit()
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 7
        }
        date.do {
            $0.font = UIFont(name: "NotoSansKR-Medium", size: 13)
            $0.textColor = UIColor.appColor(.studySubTitle)
        }
        managerImage.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10
        }
        memberImage.do {
            $0.image = UIImage(named: "member")
        }
        memberCount.do {
            $0.textColor = .white
            $0.font = UIFont(name: "NotoSansKR-Bold", size: 20)
            $0.textAlignment = .center
        }
    }
    
    func layout() {
        [mainTitle, subTitle, date, managerImage, mainImage, location, memberImage, memberCount].forEach { self.contentView.addSubview($0)
        }
       
        self.mainTitle.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        }
        
        self.subTitle.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.mainImage.leadingAnchor, constant: -10).isActive = true
        }
        
        self.date.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        }
        
        self.managerImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 13).isActive = true
            $0.leadingAnchor.constraint(equalTo: date.trailingAnchor, constant: 10).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 20).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 20).isActive = true
        }
        
        self.mainImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 75).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 112).isActive = true
        }
        
        self.location.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: mainImage.leadingAnchor, constant: -20).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 22).isActive = true
        }
        
        self.memberImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.location.leadingAnchor, constant: 5).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 25).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 25).isActive = true
        }
        
        self.memberCount.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.memberImage.trailingAnchor, constant: 2).isActive = true
        }
    }
}
