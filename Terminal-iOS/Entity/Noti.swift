//
//  Noti.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

// 알림에 대한 모델

struct Noti: Codable {
    let id, studyID: Int
    let pushEvent, message, createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case studyID
        case pushEvent, message
        case createdAt
    }
}
