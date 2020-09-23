//
//  StudyCell.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Then

class StudyCell: UITableViewCell {
    static let cellId = "cellId"
    
    let mainTitle = UILabel()
    let location = UILabel()
    let subTitle = UILabel()
    let date = UILabel()
    let managerImage = UIImageView()
    let mainImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ data: Study) {
        mainTitle.do {
            $0.text = data.title
        }
        
        subTitle.do {
            $0.text = data.subTitle
        }
        
        location.do {
            $0.text = data.location
        }
        
        date.do {
            $0.text = data.date
        }
        
        managerImage.do {
            $0.image = data.managerImage
        }
        
        mainImage.do {
            $0.image = data.mainImage
        }
    }
    
    func attribute() {
        self.backgroundColor = UIColor.appColor(.terminalBackground)
        mainTitle.do {
            $0.textColor = .white
        }
        subTitle.do {
            $0.textColor = UIColor.appColor(.studySubTitle)
        }
        location.do {
            $0.backgroundColor = .white
            $0.textColor = .black
            $0.textAlignment = .center
            $0.sizeToFit()
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 7
            
        }
        date.do {
            $0.textColor = .white
        }
        managerImage.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10
        }
    }
    
    func layout() {
        addSubview(mainTitle)
        addSubview(subTitle)
        addSubview(date)
        addSubview(managerImage)
        addSubview(mainImage)
        addSubview(location)
        
        mainTitle.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        }
        
        subTitle.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        }
        
        date.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        }
        
        managerImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: date.trailingAnchor, constant: 10).isActive = true
        }
        
        mainImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 75).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 112).isActive = true
        }
        
        location.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: mainImage.leadingAnchor, constant: -20).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 22).isActive = true
        }
    }
}
