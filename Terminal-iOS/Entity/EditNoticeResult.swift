//
//  EditNoticeResult.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/31.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

struct EditNoticeResult: Codable {
    let noticeID: Int
    
    enum CodingKeys: String, CodingKey {
        case noticeID = "notice_id"
    }
}
