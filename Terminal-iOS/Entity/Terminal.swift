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
    
    static let accessToken = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjMsImVtYWlsIjoic3Nzc0Bzc3Nzcy5jb20iLCJuaWNrbmFtZSI6IuqzoOyWkeydtOufrOyWtCIsImlhdCI6MTYwNjgyNzk3OCwiZXhwIjoxMDYwNjgyNzk3OCwiaXNzIjoidGVybWluYWwtc2VydmVyIiwic3ViIjoidXNlckluZm8tYWNjZXNzIn0.x0vKrkzEsN3-Qejhd8Rso6rdxeM2CwwSqCsfnCVlB9Q"
    
    static let tempToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTIsImVtYWlsIjoibW9ja0BuYXZlci5jb20iLCJuaWNrbmFtZSI6IuuqqeyXheuLieuEpOyehCIsImlhdCI6MTYwNjQ2MjUwNiwiZXhwIjoxMDYwNjQ2MjUwNiwiaXNzIjoidGVybWluYWwtc2VydmVyIiwic3ViIjoidXNlckluZm8tYWNjZXNzIn0.dvFg82yOCZlnUir-MTUjjSa-7DFFJkPy9qdnWDRhnxor"
    
    static let refreshToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTIsImlhdCI6MTYwNjQ0OTYwMCwiZXhwIjoxNjA3NzQ1NjAwLCJpc3MiOiJ0ZXJtaW5hbC1zZXJ2ZXIiLCJzdWIiOiJ1c2VySW5mby1yZWZyZXNoIn0.Rnk7_wsHb3UiymDt3gAHE_wAFgfZd9SnC0t-i1krwQE"

    static func convertHeigt(value: CGFloat) -> CGFloat{
        return screenSize.height * (value / 667)
    }
    
    static func convertWidth(value: CGFloat) -> CGFloat {
        return screenSize.width * (value / 375)
    }
    
    static let token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTIsImVtYWlsIjoibW9ja0BuYXZlci5jb20iLCJuaWNrbmFtZSI6IuuqqeyXheuLieuEpOyehCIsImlhdCI6MTYwNjQ2MjUwNiwiZXhwIjoxMDYwNjQ2MjUwNiwiaXNzIjoidGVybWluYWwtc2VydmVyIiwic3ViIjoidXNlckluZm8tYWNjZXNzIn0.dvFg82yOCZlnUir-MTUjjSa-7DFFJkPy9qdnWDRhnxo"
}
