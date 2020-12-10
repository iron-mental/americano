//
//  HotKeyword.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/10.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

struct HotKeyword: Codable {
    let word: String
    
    enum CodingKeys: String, CodingKey {
        case word
    }
}
