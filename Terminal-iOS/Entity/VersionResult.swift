//
//  VersionResult.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/23.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

struct VersionResult: Codable {
    let latestVersion: String?
    let force: VersionResultType.RawValue
    let maintenance: Bool
    
    enum CodingKeys: String, CodingKey {
        case latestVersion = "latest_version"
        case force, maintenance
    }
}
