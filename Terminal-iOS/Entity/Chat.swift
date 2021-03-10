//
//  Chat.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/03/11.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

struct Chat: Codable {
    let studyID: Int
    let nickname: String
    let message: String
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case studyID = "study_id"
        case nickname, message, date
    }
}
