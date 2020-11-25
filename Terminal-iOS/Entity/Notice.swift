//
//  NoticeDetail.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

// MARK: 스터디 상세

struct NoticeDetail: Codable {
    let result: Bool
    let data: Notice
}

// MARK: 스터디 리스트

struct NoticeList: Codable {
    let result: Bool
    let data: [Notice]
}

// MARK: 스터디 

struct Notice: Codable {
    let id: Int
    let studyID: Int?
    let title, contents: String
    let pinned: Bool
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case studyID = "study_id"
        case title, contents, pinned
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

