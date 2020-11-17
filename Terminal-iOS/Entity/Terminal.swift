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
    
    static let accessToken = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJya2RjamYwMTIyQG5hdmVyLmNvbSIsIm5pY2tuYW1lIjoi64uJ64S067OA6rK97ZWoIiwiaWF0IjoxNjA1NjA2ODQwLCJleHAiOjE2MDY5MDI4NDAsImlzcyI6InRlcm1pbmFsLXNlcnZlciIsInN1YiI6InVzZXJJbmZvLWFjY2VzcyJ9.hEgLgyJxYFAL1VoECYoeX0zvRrOpuNgS1Ol1s2sj6X0"
    
    static let refreshToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjA1NjAyMTQ2LCJleHAiOjE2MDY4OTgxNDYsImlzcyI6InRlcm1pbmFsLXNlcnZlciIsInN1YiI6InVzZXJJbmZvLXJlZnJlc2gifQ.bvyYvz22pjDZBGlu2ElQ1mGWYm1xqqoCEIsySXaI8q0"

    static func convertHeigt(value: CGFloat) -> CGFloat{
        return screenSize.height * (value / 667)
    }
    
    static func convertWidth(value: CGFloat) -> CGFloat {
        return screenSize.width * (value / 375)
    }
}
