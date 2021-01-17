//
//  Address.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/11.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

struct Address: Codable {
    let sido: String
    let sigungu: [String]

    enum CodingKeys: String, CodingKey {
        case sido
        case sigungu
    }
}
