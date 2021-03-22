//
//  Notice.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

struct Notice: Codable {
    var id: Int
    let title, contents: String?
    let leaderID: Int?
    var studyID: Int?
    let pinned: Bool?
    let updatedAt: String?
    let leaderImage: String?
    let leaderNickname: String?
    let createAt: String?
    let isPaging: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case studyID = "study_id"
        case title, contents, pinned
        case updatedAt = "updated_at"
        case createAt = "create_at"
        case leaderID = "leader_id"
        case leaderImage = "leader_image"
        case leaderNickname = "leader_nickname"
        case isPaging = "is_paging"
    }
}
