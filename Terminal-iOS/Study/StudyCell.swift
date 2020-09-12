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
        attribute()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attribute() {
//        title1.text = "스니커즈 어플 만드실분"
//        subTitle.text = "안녕하세요 많은 참여 부탁드립니다."
//        location.text = "강남구"
//        date.text = "4/23 |"
//        managerImage.image = #imageLiteral(resourceName: "Image-1")
//        mainImage.image = #imageLiteral(resourceName: "Image")
    }
    
    func layout() {
        addSubview(title1)
        title1.translatesAutoresizingMaskIntoConstraints = false
        title1.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        title1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        
        addSubview(subTitle)
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        subTitle.topAnchor.constraint(equalTo: title1.bottomAnchor, constant: 10).isActive = true
        subTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        
        addSubview(date)
        date.translatesAutoresizingMaskIntoConstraints = false
        date.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 10).isActive = true
        leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        
        addSubview(managerImage)
        managerImage.translatesAutoresizingMaskIntoConstraints = false
        managerImage.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 10).isActive = true
        managerImage.leadingAnchor.constraint(equalTo: date.trailingAnchor, constant: 10).isActive = true
        
        addSubview(mainImage)
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        mainImage.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        mainImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        mainImage.heightAnchor.constraint(equalToConstant: 75).isActive = true
        mainImage.widthAnchor.constraint(equalToConstant: 112).isActive = true
    }
}
