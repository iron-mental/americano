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
    let studyTitle, message: String
    let pushEvent, createdAt: String
    let confirm: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case studyTitle = "study_title"
        case studyID = "study_id"
        case pushEvent, message
        case createdAt = "created_at"
        case confirm
    }
}
