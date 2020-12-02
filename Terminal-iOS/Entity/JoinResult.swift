//
//  JoinResult.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/02.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

struct JoinResult: Codable {
    let id: Int?
    let accessToken, refreshToken: String?

    enum CodingKeys: String, CodingKey {
        case id
        case accessToken
        case refreshToken
    }
}
