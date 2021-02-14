//
//  StudyDetail.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/13.
//  Copyright © 2020 정재인. All rights reserved.
//
import Foundation

// MARK: 스터디 상세

struct StudyDetailInfo: Codable {
    let studyInfo: StudyDetail
    let badge: Badge
}
struct StudyDetail: Codable {
    let participate: [Participate]
    let id: Int
    let category, title, introduce: String
    let progress, studyTime: String
    let snsWeb, snsNotion, snsEvernote, image: String?
    
    let location: Location
    
    let authority: String
    
    enum CodingKeys: String, CodingKey {
        case participate, id, category, title, introduce, image, progress
        case studyTime = "study_time"
        case snsNotion = "sns_notion"
        case snsEvernote = "sns_evernote"
        case snsWeb = "sns_web"
        case location
        case authority = "Authority"
    }
}

struct Location: Codable {
    let latitude, longitude, addressName: String
    let locationDetail, placeName: String?
    
    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case addressName = "address_name"
        case placeName = "place_name"
        case locationDetail = "location_detail"
    }
}

struct Participate: Codable {
    let id, userID: Int
    let nickname: String
    let image: String?
    let leader: Bool
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case nickname, image, leader
    }
}
