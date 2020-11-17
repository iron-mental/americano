//
//  Terminal.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class Terminal {
    
    //kakao
    //bce7f6969838f58c8c27fa25722c220b
    static let screenSize = UIScreen.main.bounds

    static func convertHeigt(value: CGFloat) -> CGFloat{
        return screenSize.height * (value / 667)
    }
    
    static func convertWidth(value: CGFloat) -> CGFloat {
        return screenSize.width * (value / 375)
    }
    
    static let token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE2MDUyNTg3MTcsImV4cCI6MTYwNjU1NDcxNywiaXNzIjoidGVybWluYWwtc2VydmVyIiwic3ViIjoidXNlckluZm8tYWNjZXNzIn0.ERdupceGRDZAJbnA6hgstoUUYwMoaxm_kqxXneJM6Xo"
}
