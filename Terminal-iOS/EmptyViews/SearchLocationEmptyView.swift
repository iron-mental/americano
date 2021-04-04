//
//  SearchLocationEmptyView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/17.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

final class SearchLocationListEmptyView: BaseEmptyView {
    override func attribute() {
        super.attribute()
        self.iconImageView.do {
            $0.image = UIImage(systemName: "magnifyingglass.circle")?.withConfiguration(UIImage.SymbolConfiguration(weight: .light))
        }
        self.guideLabel.do {
            $0.text = "검색 결과가 없습니다.\n키워드를 입력해 주세요"
            $0.numberOfLines = 0
        }
    }
    
    override func layout() {
        super.layout()
        if UIDevice.current.userInterfaceIdiom == .pad {
            guideLabelTopLayout?.isActive = false
            guideLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: Terminal.convertHeight(value: 100)).isActive = true
        }
    }
}
