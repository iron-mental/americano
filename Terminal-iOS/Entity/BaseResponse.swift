//
//  BaseResponse.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    let result: Bool
    let type, label, message: String?
    let data: T?
    
    enum CodingKeys: String, CodingKey {
        case result
        case type, label, message
        case data
    }
}
