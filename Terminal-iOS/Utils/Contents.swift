//
//  Contents.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/03.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

enum API {
    static let BASE_URL: String = "http://3.35.154.27:3000/v1/"
    
    static let ACCESS_TOKEN: String = KeychainWrapper.standard.string(forKey: "accessToken")!
//    static let tempToken = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDQsImVtYWlsIjoic3dkb3Jpc0BnbWFpbC5jb20iLCJuaWNrbmFtZSI6IuycpOyDgeybkCIsImlhdCI6MTYwNjkwMTYzOSwiZXhwIjoxNjA2OTAxNjQwLCJpc3MiOiJ0ZXJtaW5hbC1zZXJ2ZXIiLCJzdWIiOiJ1c2VySW5mby1hY2Nlc3MifQ.OtG1wZf8ANLtgS0fxmcs0E04yGvTRexmpzZQD5gGy2U"
    static let REFRESH_TOKEN: String = KeychainWrapper.standard.string(forKey: "refreshToken")!
}
