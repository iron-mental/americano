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
    
    let title1 = UILabel()
    let location = UILabel()
    let subTitle = UILabel()
    let date = UILabel()
    let managerImage = UIImageView()
    let mainImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ data: Study) {
        title1.do {
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
    
    func layout() {
        addSubview(title1)
        title1.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        }
        
        addSubview(subTitle)
        subTitle.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: title1.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        }
        
        addSubview(date)
        date.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        }
        
        addSubview(managerImage)
        managerImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: date.trailingAnchor, constant: 10).isActive = true
        }
        
        addSubview(mainImage)
        mainImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 75).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 112).isActive = true
        }
    }
}
