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
    static let temp2Token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OSwiZW1haWwiOiJya2RjamYwMTIyQGdtYWlsLmNvbSIsIm5pY2tuYW1lIjoi64uJ64S0IiwiaWF0IjoxNjA3MTAwMjI5LCJleHAiOjEwNjA3MTAwMjI5LCJpc3MiOiJ0ZXJtaW5hbC1zZXJ2ZXIiLCJzdWIiOiJ1c2VySW5mby1hY2Nlc3MifQ.fYLA_ZAW85Q42NWHjXNDqzFrYqa3PqSdMwL6oAL6LGk"
    static let accessToken = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTIsImVtYWlsIjoibW9ja0BuYXZlci5jb20iLCJuaWNrbmFtZSI6IuuqqeyXheuLieuEpOyehCIsImlhdCI6MTYwNjc0MDkxOSwiZXhwIjoxMDYwNjc0MDkxOSwiaXNzIjoidGVybWluYWwtc2VydmVyIiwic3ViIjoidXNlckluZm8tYWNjZXNzIn0.J4qv-Md8HoISWFnUtGl-LDRnHf8zYh4CEx8FqKN2Gmw"
    
    static let tempToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTIsImVtYWlsIjoibW9ja0BuYXZlci5jb20iLCJuaWNrbmFtZSI6IuuqqeyXheuLieuEpOyehCIsImlhdCI6MTYwNjc0MDkxOSwiZXhwIjoxMDYwNjc0MDkxOSwiaXNzIjoidGVybWluYWwtc2VydmVyIiwic3ViIjoidXNlckluZm8tYWNjZXNzIn0.J4qv-Md8HoISWFnUtGl-LDRnHf8zYh4CEx8FqKN2Gmw"
    
    static let refreshToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTIsImlhdCI6MTYwNjQ0OTYwMCwiZXhwIjoxNjA3NzQ1NjAwLCJpc3MiOiJ0ZXJtaW5hbC1zZXJ2ZXIiLCJzdWIiOiJ1c2VySW5mby1yZWZyZXNoIn0.Rnk7_wsHb3UiymDt3gAHE_wAFgfZd9SnC0t-i1krwQE"

    static func convertHeigt(value: CGFloat) -> CGFloat{
        return screenSize.height * (value / 667)
    }
    
    static func convertWidth(value: CGFloat) -> CGFloat {
        return screenSize.width * (value / 375)
    }
    
    static let token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTIsImVtYWlsIjoibW9ja0BuYXZlci5jb20iLCJuaWNrbmFtZSI6IuuqqeyXheuLieuEpOyehCIsImlhdCI6MTYwNjc0MDkxOSwiZXhwIjoxMDYwNjc0MDkxOSwiaXNzIjoidGVybWluYWwtc2VydmVyIiwic3ViIjoidXNlckluZm8tYWNjZXNzIn0.J4qv-Md8HoISWFnUtGl-LDRnHf8zYh4CEx8FqKN2Gmwr"
}
