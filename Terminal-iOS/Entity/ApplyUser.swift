//
//  ApplyUser.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

struct ApplyUser: Codable {
    let id, userID: Int
    let image, message, nickname: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case image, message, nickname
    }
}
