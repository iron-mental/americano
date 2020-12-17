//
//  TempMyStudyList.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/08.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

struct MyStudy: Codable {
    var id: Int
    var title: String
    var sigungu: String
    var image: String?
}

class TempMyStudyList {
    static var list: [MyStudy] = []
}
