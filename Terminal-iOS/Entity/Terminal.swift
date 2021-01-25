//
//  Terminal.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class Terminal {
    static let kakaoKey = "bce7f6969838f58c8c27fa25722c220b"
    
    static let screenSize = UIScreen.main.bounds
    
    static let githubKey = "3e5f8c2c78dffa5dd1d4fdf729060ca9bb703a65"
    
    static func convertHeigt(value: CGFloat) -> CGFloat {
        return screenSize.height * (value / 667)
    }
    
    static func convertWidth(value: CGFloat) -> CGFloat {
        return screenSize.width * (value / 375)
    }
    static let token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDQsImVtYWlsIjoic3dkb3Jpc0BnbWFpbC5jb20iLCJuaWNrbmFtZSI6IuycpOyDgeybkCIsImlhdCI6MTYwNzA4NzQ5NSwiZXhwIjoxMDYwNzA4NzQ5NSwiaXNzIjoidGVybWluYWwtc2VydmVyIiwic3ViIjoidXNlckluZm8tYWNjZXNzIn0.b3dYBzHr9ll524AVLeJ5sB678l1fiBQev9CCTeYl9AE"
}
