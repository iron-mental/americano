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
    static let temp2Token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDksImVtYWlsIjoiamFlaW5tb2NrMUBuYXZlci5jb20iLCJuaWNrbmFtZSI6IuyerOyduOOFi-OFi-OFiyIsImlhdCI6MTYwNzkzOTgwNSwiZXhwIjoxNjA4MDI5ODA1LCJpc3MiOiJ0ZXJtaW5hbC1zZXJ2ZXIiLCJzdWIiOiJ1c2VySW5mby1hY2Nlc3MifQ.05xEMllzSH0qg-JlZc2jFIHTzz8g03bnOLn06ZpXWho"
    static let accessToken = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDksImVtYWlsIjoiamFlaW5tb2NrMUBuYXZlci5jb20iLCJuaWNrbmFtZSI6IuyerOyduOOFi-OFi-OFiyIsImlhdCI6MTYwNzkzOTgwNSwiZXhwIjoxNjA4MDI5ODA1LCJpc3MiOiJ0ZXJtaW5hbC1zZXJ2ZXIiLCJzdWIiOiJ1c2VySW5mby1hY2Nlc3MifQ.05xEMllzSH0qg-JlZc2jFIHTzz8g03bnOLn06ZpXWho"
    
    static let refreshToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDksImVtYWlsIjoiamFlaW5tb2NrMUBuYXZlci5jb20iLCJuaWNrbmFtZSI6IuyerOyduOOFi-OFi-OFiyIsImlhdCI6MTYwNzkzOTgwNSwiZXhwIjoxNjA4MDI5ODA1LCJpc3MiOiJ0ZXJtaW5hbC1zZXJ2ZXIiLCJzdWIiOiJ1c2VySW5mby1hY2Nlc3MifQ.05xEMllzSH0qg-JlZc2jFIHTzz8g03bnOLn06ZpXWho"

    static func convertHeigt(value: CGFloat) -> CGFloat{
        return screenSize.height * (value / 667)
    }
    
    static func convertWidth(value: CGFloat) -> CGFloat {
        return screenSize.width * (value / 375)
    }
    
    static let token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDQsImVtYWlsIjoic3dkb3Jpc0BnbWFpbC5jb20iLCJuaWNrbmFtZSI6IuycpOyDgeybkCIsImlhdCI6MTYwNzA4NzQ5NSwiZXhwIjoxMDYwNzA4NzQ5NSwiaXNzIjoidGVybWluYWwtc2VydmVyIiwic3ViIjoidXNlckluZm8tYWNjZXNzIn0.b3dYBzHr9ll524AVLeJ5sB678l1fiBQev9CCTeYl9AE"
    static var keyboardHeight: CGFloat = 0.0
}
