//
//  CategoryCell.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Then
import SwiftKeychainWrapper
import Kingfisher

class CategoryCell: UICollectionViewCell {
    static let categoryCellID = "categoryCellID"

    let categoryView = CategoryImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    func setData(category: Category) {
        self.categoryView.title.text = category.name
        if !category.image.isEmpty {
            self.categoryView.image.kf.setImage(with: URL(string: category.image)!,
                                                options: [.requestModifier(RequestToken.token())])
        } else {
            self.categoryView.image.image = nil
        }
    }
    
    private func layout() {
        self.contentView.addSubview(self.categoryView)
        self.categoryView.do {
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
