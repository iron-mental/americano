//
//  NotiListEmptyView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/17.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit


class NotiListEmptyView: BaseEmptyView {
    override func attribute() {
        super.attribute()
        self.iconImageView.do {
            $0.image = UIImage(systemName: "envelope.fill")?.withConfiguration(UIImage.SymbolConfiguration(weight: .light))
        }
        self.guideLabel.do {
            $0.text = "도착한 알림이 없습니다."
        }
    }
    override func layout() {
        super.layout()
    }
}
