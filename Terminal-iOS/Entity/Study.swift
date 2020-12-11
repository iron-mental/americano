//
//  Study.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

//MARK : 스터디 리스트

//struct StudyList: Codable {
//    let result: Bool
//    let data: [Study]
//}

struct Study: Codable {
    let id: Int
    let title, introduce, image, sigungu: String?
    let leaderImage, createdAt: String?
    let members: Int?
    let isMember: Bool?

    enum CodingKeys: String, CodingKey {
        case id, title, introduce, image, sigungu, isMember
        case leaderImage = "leader_image"
        case createdAt = "created_at"
        case members
    }
}
