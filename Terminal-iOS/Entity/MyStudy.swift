//
//  MyStudy.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/29.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

struct MyStudyList: Codable {
    var studyList: [MyStudy]?
    var badge: Badge?
}
struct MyStudy: Codable {
    var id: Int
    var title: String
    var sigungu: String
    var image: String?
}

struct Badge: Codable {
    var alert: Int
    var total: Int
}
