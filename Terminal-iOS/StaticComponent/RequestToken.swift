//
//  Token.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/27.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper
import Kingfisher

struct RequestToken {
    static func token() -> AnyModifier {
        let token = KeychainWrapper.standard.string(forKey: "accessToken")!
        return AnyModifier { request in
            var requestBody = request
            requestBody.setValue("Bearer "+token, forHTTPHeaderField: "Authorization")
            return requestBody
        }
    }
}
