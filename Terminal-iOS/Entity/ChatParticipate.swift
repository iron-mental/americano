//
//  ChatParticipate.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/03/14.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

struct ChatParticipate: Codable, Hashable {
    let userID: Int
    let nickname: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case nickname
    }
}
