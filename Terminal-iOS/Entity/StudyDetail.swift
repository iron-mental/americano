//
//  StudyDetail.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/13.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

struct StudyDetail: Codable {
    let id: Int
    let category, title, introduce, image: String
    let progress, studyTime, snsNotion, snsEvernote: String
    let snsWeb: String
    let location: Location

    enum CodingKeys: String, CodingKey {
        case id, category, title, introduce, image, progress
        case studyTime
        case snsNotion
        case snsEvernote
        case snsWeb
        case location
    }
}

struct Location: Codable {
    let latitude, longitude, addressName, placeName: String
    let locationDetail: String

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case addressName
        case placeName
        case locationDetail
    }
}
