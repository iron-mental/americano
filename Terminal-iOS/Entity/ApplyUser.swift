//
//  ApplyUser.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

struct ApplyUser: Codable {
    let id, studyID: Int
    let message, title: String
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id
        case studyID
        case message, title, image
    }
}
