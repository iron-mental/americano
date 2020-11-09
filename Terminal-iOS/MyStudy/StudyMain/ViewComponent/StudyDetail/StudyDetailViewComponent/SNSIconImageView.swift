//
//  SNSIconImageView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SNSIconImageView: UIImageView {
    
    init() {
        super.init(frame: CGRect.zero)
        attribute()
    }
    
    func attribute() {
        self.do {
            $0.image = #imageLiteral(resourceName: "invaild")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
