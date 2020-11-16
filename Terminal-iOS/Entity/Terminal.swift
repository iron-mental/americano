//
//  Terminal.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class Terminal {
    
    
    static let kakaoKey = "bce7f6969838f58c8c27fa25722c220b"
    
    static let screenSize = UIScreen.main.bounds
    
    static let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOjEyLCJlbWFpbCI6Im1vY2tAbmF2ZXIuY29tIiwiaWF0IjoxNjA1NTE3ODMxLCJleHAiOjE2MDY4MTM4MzEsImlzcyI6InRlcm1pbmFsLXNlcnZlciIsInN1YiI6InVzZXJJbmZvLWFjY2VzcyJ9.CXSLLq_8iIarsskid4-6WZPXG6C_Q_CAR4ieVeukMys"
    
    static let refreshToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOjEyLCJpYXQiOjE2MDU1MTc4MzEsImV4cCI6MTYwNjgxMzgzMSwiaXNzIjoidGVybWluYWwtc2VydmVyIiwic3ViIjoidXNlckluZm8tcmVmcmVzaCJ9.mW08UmE1qr9WC3PmPXHnXvEmD_438b4_BwlJA_8e7yE"

    static func convertHeigt(value: CGFloat) -> CGFloat{
        return screenSize.height * (value / 667)
    }
    
    static func convertWidth(value: CGFloat) -> CGFloat {
        return screenSize.width * (value / 375)
    }
}
