//
//  CategoryCell.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Then

class CategoryCell: UICollectionViewCell {
    static let categoryCellID = "categoryCellID"

    let category = CategoryImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    func setData(category: Category) {
        self.category.image.image = category.image
        self.category.title.text = category.name
    }
    
    private func layout() {
        self.contentView.addSubview(self.category)
        self.category.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
