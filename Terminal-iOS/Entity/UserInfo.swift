//
//  UserInfo.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/26.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

// MARK: 유저 정보

struct UserInfo: Codable {
    let id: Int
    let nickname, email: String
    let image, introduce: String?
    let sido, sigungu: String?
    let careerTitle, careerContents: String?
    let snsLinkedin, snsWeb, snsGithub: String?
    let emailVerified: Bool
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, nickname, email, image, introduce
        case sido, sigungu
        case careerTitle = "career_title"
        case careerContents = "career_contents"
        case snsGithub = "sns_github"
        case snsLinkedin = "sns_linkedin"
        case snsWeb = "sns_web"
        case emailVerified = "email_verified"
        case createdAt = "created_at"
    }
}
