//
//  ApplyListCell.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Kingfisher
import Then

class ApplyListCell: UITableViewCell {
    static let cellID = "fdfdfdfd"
    lazy var mainImage = UIImageView()
    lazy var title = UILabel()
    lazy var contents = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    func setData(studies: ApplyStudy) {
        let imageDownloadRequest = AnyModifier { request in
            var requestBody = request
            requestBody.setValue(Terminal.token, forHTTPHeaderField: "Authorization")
            return requestBody
        }
        
        if let imageURL = studies.image {
            self.mainImage.kf.setImage(with: URL(string: imageURL), options: [.requestModifier(imageDownloadRequest)])
        }
        
        self.title.text = studies.title
        self.contents.text = studies.message
    }
    
    func attribute() {
        self.mainImage.do {
            $0.image = #imageLiteral(resourceName: "mystudy")
            $0.contentMode = .scaleAspectFit
        }
        self.title.do {
            $0.numberOfLines = 0
            $0.textColor = .white
            $0.dynamicFont(fontSize: 18, weight: .semibold)
        }
        self.contents.do {
            $0.numberOfLines = 3
            $0.textColor = UIColor.appColor(.studySubTitle)
            $0.dynamicFont(fontSize: 14, weight: .regular)
        }
    }
    
    func layout() {
        [mainImage, title, contents].forEach{ self.contentView.addSubview($0)}
        self.mainImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
            $0.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 53)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 53)).isActive = true
        }
        self.title.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.mainImage.trailingAnchor, constant: 23).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 20)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 100)).isActive = true
        }
        self.contents.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.title.trailingAnchor,
                                        constant: Terminal.convertWidth(value: 20)).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 200)).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
