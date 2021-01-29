//
//  StudyDetailPost.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/26.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

// MARK: 스터디 상세

struct StudyDetailPost {
    let category: String
    let title, introduce: String?
    let progress, studyTime: String?
    let snsWeb, snsNotion, snsEvernote: String?
    let image: UIImage?
    let location: StudyDetailLocationPost?
}

struct StudyDetailLocationPost: Codable {
    var address: String
    var lat: Double
    var lng: Double
    var detailAddress: String?
    var placeName: String?
    var category: String?
    var sido: String
    var sigungu: String
    
    enum CodingKeys: String, CodingKey {
        case address
        case lat = "y"
        case lng = "x"
        case detailAddress
        case placeName
        case category
        case sido
        case sigungu
    }
}
