//
//  projectList.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

// MARK: 프로젝트 리스트

struct ProjectList: Codable {
    let result: Bool
    let data: [Project]
}

// MARK: 프로젝트

struct Project: Codable {
    let id: Int
    let title, contents: String
    let snsGithub, snsAppstore, snsPlaystore: String?
    let createAt: String

    enum CodingKeys: String, CodingKey {
        case id, title, contents
        case snsGithub = "sns_github"
        case snsAppstore = "sns_appstore"
        case snsPlaystore = "sns_playstore"
        case createAt = "create_at"
    }
}
