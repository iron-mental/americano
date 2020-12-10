//
//  Authorization.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

struct Authorization: Codable {
    let accessToken, refreshToken: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case id
    }
}
