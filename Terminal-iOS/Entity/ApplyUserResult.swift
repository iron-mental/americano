//
//  ApplyUserResult.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/11.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

struct ApplyUserResult: Codable {
    let id: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case id, message
    }
}
