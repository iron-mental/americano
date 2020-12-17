//
//  ApplyStudy.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

struct ApplyStudy: Codable {
    let studyID, id: Int
    let message, title: String
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case studyID = "study_id"
        case id, message, image, title
    }
}
