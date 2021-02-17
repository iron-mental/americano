//
//  MyStudyListEmptyView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/17.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit


class MyStudyListEmptyView: BaseEmptyView {
    override func attribute() {
        super.attribute()
        self.iconImageView.do {
            $0.image = UIImage(systemName: "person.3.fill")?.withConfiguration(UIImage.SymbolConfiguration(weight: .light))
        }
        self.guideLabel.do {
            $0.text = "참여중인 스터디가 없습니다."
        }
    }
    override func layout() {
        super.layout()
    }
}
