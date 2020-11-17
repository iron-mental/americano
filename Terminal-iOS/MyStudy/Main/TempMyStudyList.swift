//
//  TempMyStudyList.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/08.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation



struct MyStudy: Codable {
    let id: Int
    let title: String
    let sigungu: String
    let image: String?
}


class TempMyStudyList {
    static var list: [MyStudy] = []
}
