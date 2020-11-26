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
    
    static let githubKey = "3e5f8c2c78dffa5dd1d4fdf729060ca9bb703a65"
    
    static let accessToken = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJya2RjamYwMTIyQG5hdmVyLmNvbSIsIm5pY2tuYW1lIjoi64uJ64S067OA6rK97ZWo7JqUIiwiaWF0IjoxNjA2Mzc3MTc2LCJleHAiOjEwNjA2Mzc3MTc2LCJpc3MiOiJ0ZXJtaW5hbC1zZXJ2ZXIiLCJzdWIiOiJ1c2VySW5mby1hY2Nlc3MifQ.8Do5Swmkj9tbM4r8AOuyzFXCHkQbfwNX6KjuOSsG2vE"
    
    static let tempToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJya2RjamYwMTIyQG5hdmVyLmNvbSIsIm5pY2tuYW1lIjoi64uJ64S067OA6rK97ZWo7JqUIiwiaWF0IjoxNjA2Mzc3MTc2LCJleHAiOjEwNjA2Mzc3MTc2LCJpc3MiOiJ0ZXJtaW5hbC1zZXJ2ZXIiLCJzdWIiOiJ1c2VySW5mby1hY2Nlc3MifQ.8Do5Swmkj9tbM4r8AOuyzFXCHkQbfwNX6KjuOSsG2vE"
    
    static let refreshToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjA1NjAyMTQ2LCJleHAiOjE2MDY4OTgxNDYsImlzcyI6InRlcm1pbmFsLXNlcnZlciIsInN1YiI6InVzZXJJbmZvLXJlZnJlc2gifQ.bvyYvz22pjDZBGlu2ElQ1mGWYm1xqqoCEIsySXaI8q0"

    static func convertHeigt(value: CGFloat) -> CGFloat{
        return screenSize.height * (value / 667)
    }
    
    static func convertWidth(value: CGFloat) -> CGFloat {
        return screenSize.width * (value / 375)
    }
    
    static let token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJya2RjamYwMTIyQG5hdmVyLmNvbSIsIm5pY2tuYW1lIjoi64uJ64S067OA6rK97ZWo7JqUIiwiaWF0IjoxNjA2Mzc3MTc2LCJleHAiOjEwNjA2Mzc3MTc2LCJpc3MiOiJ0ZXJtaW5hbC1zZXJ2ZXIiLCJzdWIiOiJ1c2VySW5mby1hY2Nlc3MifQ.8Do5Swmkj9tbM4r8AOuyzFXCHkQbfwNX6KjuOSsG2vE"
}
