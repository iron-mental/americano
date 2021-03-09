//
//  freshAccessToken.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

// MARK: 엑세스 토큰

struct AccessToken: Codable {
    let result: Bool
    let data: Token
}

struct Token: Codable {
    let accessToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}
