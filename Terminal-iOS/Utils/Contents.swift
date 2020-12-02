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

    static let REFRESH_TOKEN: String = KeychainWrapper.standard.string(forKey: "refreshToken")!
}
