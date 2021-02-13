//
//  MemberCollectionView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class MemberCollectionView: UICollectionView {
    
    let layoutValue: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    init(frame: CGRect) {
        super.init(frame: frame, collectionViewLayout: layoutValue)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attribute() {
        self.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.register(MemberCollectionViewCell.self, forCellWithReuseIdentifier: MemberCollectionViewCell.identifier)
            $0.isPagingEnabled = false
            $0.showsHorizontalScrollIndicator = false
        }
        layoutValue.do {
            $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            $0.minimumLineSpacing = 10
            $0.minimumInteritemSpacing = 10
            $0.itemSize = CGSize(width: Terminal.convertWidth(value: 46), height: Terminal.convertHeight(value: 65))
            $0.scrollDirection = .horizontal
        }
    }
    
    func layout() {
        self.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 65)).isActive = true
            $0.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        }
    }
}
