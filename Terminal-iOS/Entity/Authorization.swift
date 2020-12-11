//
//  Authorization.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

struct Authorization: Codable {
    let id: Int?
    let accessToken, refreshToken: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
