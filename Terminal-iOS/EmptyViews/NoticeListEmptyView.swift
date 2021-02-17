//
//  NoticeListEmptyView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/17.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class NoticeListEmptyView: BaseEmptyView {
    override func attribute() {
        super.attribute()
        self.iconImageView.do {
            $0.image = UIImage(systemName: "pin.fill")?.withConfiguration(UIImage.SymbolConfiguration(weight: .light))
        }
        self.guideLabel.do {
            $0.text = "작성된 공지사항이 없습니다."
        }
    }
    override func layout() {
        super.layout()
        self.iconImageView.do {
            imageViewTopLayout?.isActive = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: Terminal.convertHeight(value: 150)).isActive = true
        }
    }
}
