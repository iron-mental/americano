//
//  MemeberView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class MemeberView: UIView {
    var title = UILabel()
    var totalMember = UILabel()
    var collectionView = MemberCollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * 0.8, height: 200))
    
    init() {
        super.init(frame: CGRect.zero)
        attribute()
        layout()
    }
    
    func attribute() {
        title.do {
            $0.text = "구성원"
            $0.font = UIFont.boldSystemFont(ofSize: 18)
        }
        totalMember.do {
            $0.text = "7 / 10"
            $0.textColor = .gray
            $0.font.withSize(16)
        }
        collectionView.do {
            $0.backgroundColor = .red
        }
    }
    
    func layout() {
        [title, totalMember, collectionView].forEach { addSubview($0) }
        
        title.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Terminal.convertWidth(value: 24)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: title.intrinsicContentSize.height).isActive = true
            $0.widthAnchor.constraint(equalToConstant: title.intrinsicContentSize.width).isActive = true
        }
        totalMember.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: title.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: Terminal.convertWidth(value: 20.8)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: totalMember.intrinsicContentSize.height).isActive = true
            $0.widthAnchor.constraint(equalToConstant: totalMember.intrinsicContentSize.width).isActive = true
        }
        collectionView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: title.bottomAnchor, constant: Terminal.convertHeigt(value: 12)).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Terminal.convertWidth(value: 24)).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 46)).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
