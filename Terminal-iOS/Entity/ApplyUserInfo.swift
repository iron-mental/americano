//
//  ApplyUserInfo.swift
//  Terminal-iOS
//
//  Created by once on 2021/03/01.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

struct ApplyUserInfo: Codable {
    let id, userID, studyID: Int
    let message, applyStatus: String
    let image: String?
    let nickname, email: String
    let sido, sigungu: String?
    let careerTitle, careerContents: String?
    let snsGithub, snsLinkedin, snsWeb: String?
    let rejectedStatus: Bool
    let rejectedAt: Int?
    let createdAt: Int
    let project: [Project]

    enum CodingKeys: String, CodingKey {
        case project, id, message
        case image, nickname, email, sido, sigungu
        case userID = "user_id"
        case studyID = "study_id"
        case applyStatus = "apply_status"
        case createdAt = "created_at"
        case rejectedAt = "rejected_at"
        case careerTitle = "career_title"
        case careerContents = "career_contents"
        case snsGithub = "sns_github"
        case snsLinkedin = "sns_linkedin"
        case snsWeb = "sns_web"
        case rejectedStatus = "rejected_status"
    }
}
