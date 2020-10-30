//
//  StudyIntroduceLabel.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class StudyIntroduceLabel: UILabel {
    func extracted() {
        self.do {
            $0.text = "안녕하세요 Swift를 정복하기 위한\n스터디에 함께 할 분을 모집중입니다.\n열심히 하실 분이라면 언제든 환영합니다.\n위의 노션링크도 참고해주세요"
            $0.font.withSize(16)
            $0.numberOfLines = 0
            $0.setLineSpacing(lineSpacing: 13, lineHeightMultiple: 0)
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        extracted()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
