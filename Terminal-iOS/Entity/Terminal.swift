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
    
    static let accessToken = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTIsImVtYWlsIjoibW9ja0BuYXZlci5jb20iLCJuaWNrbmFtZSI6IuuqqeyXheuLieuEpOyehCIsImlhdCI6MTYwNjQwMzQ5MywiZXhwIjoxMDYwNjQwMzQ5MywiaXNzIjoidGVybWluYWwtc2VydmVyIiwic3ViIjoidXNlckluZm8tYWNjZXNzIn0.nLj7Uc1DAjC6K4X3PzZwp_CEyKVWrPYXjdXII4FJvbM"
    
    static let tempToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTIsImVtYWlsIjoibW9ja0BuYXZlci5jb20iLCJuaWNrbmFtZSI6IuuqqeyXheuLieuEpOyehCIsImlhdCI6MTYwNjQwMzQ5MywiZXhwIjoxMDYwNjQwMzQ5MywiaXNzIjoidGVybWluYWwtc2VydmVyIiwic3ViIjoidXNlckluZm8tYWNjZXNzIn0.nLj7Uc1DAjC6K4X3PzZwp_CEyKVWrPYXjdXII4FJvbM"
    
    static let refreshToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjA1NjAyMTQ2LCJleHAiOjE2MDY4OTgxNDYsImlzcyI6InRlcm1pbmFsLXNlcnZlciIsInN1YiI6InVzZXJJbmZvLXJlZnJlc2gifQ.bvyYvz22pjDZBGlu2ElQ1mGWYm1xqqoCEIsySXaI8q0"

    static func convertHeigt(value: CGFloat) -> CGFloat{
        return screenSize.height * (value / 667)
    }
    
    static func convertWidth(value: CGFloat) -> CGFloat {
        return screenSize.width * (value / 375)
    }
    
    static let token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTIsImVtYWlsIjoibW9ja0BuYXZlci5jb20iLCJuaWNrbmFtZSI6IuuqqeyXheuLieuEpOyehCIsImlhdCI6MTYwNjQwMzQ5MywiZXhwIjoxMDYwNjQwMzQ5MywiaXNzIjoidGVybWluYWwtc2VydmVyIiwic3ViIjoidXNlckluZm8tYWNjZXNzIn0.nLj7Uc1DAjC6K4X3PzZwp_CEyKVWrPYXjdXII4FJvbM"
}
