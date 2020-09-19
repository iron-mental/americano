//
//  SNSCollectionView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/16.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SNSCollectionView: UICollectionView {
    let layout = UICollectionViewFlowLayout()
    
    init(frame: CGRect) {
        super.init(frame: frame, collectionViewLayout: layout)
        layout.do {
            $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            $0.minimumLineSpacing = 10
            $0.minimumInteritemSpacing = 10
            $0.itemSize = CGSize(width: 300, height: 50)
            $0.scrollDirection = .vertical
        }
        self.register(SNSCollectionViewCell.self, forCellWithReuseIdentifier: SNSCollectionViewCell.identifier)
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
