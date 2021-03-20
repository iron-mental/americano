//
//  MyApplyListEmptyView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/17.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

final class MyApplyListEmptyView: BaseEmptyView {
    override func attribute() {
        super.attribute()
        self.iconImageView.do {
            $0.image = UIImage(systemName: "figure.wave")?.withConfiguration(UIImage.SymbolConfiguration(weight: .light))
        }
        self.guideLabel.do {
            $0.text = "신청한 스터디가 없습니다."
        }
    }
    override func layout() {
        super.layout()
        self.iconImageView.do {
            imageViewTopLayout?.isActive = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: Terminal.convertHeight(value: 300)).isActive = true
        }
        self.guideLabel.do {
            guideLabelTopLayout?.isActive = false
            if UIDevice.current.userInterfaceIdiom == .pad {
                $0.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: Terminal.convertHeight(value: 200)).isActive = true
            } else {
                $0.topAnchor.constraint(equalTo: self.iconImageView.bottomAnchor, constant: Terminal.convertHeight(value: 100)).isActive = true
            }
        }
        
    }
}
