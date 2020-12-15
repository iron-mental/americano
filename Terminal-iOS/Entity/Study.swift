//
//  Study.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

//MARK : 스터디 리스트

struct Study: Codable {
    let id: Int
    let title, introduce, image, sigungu: String?
    let leaderImage, createdAt: String?
    let members: Int?
    let isMember: Bool?

    enum CodingKeys: String, CodingKey {
        case id, title, introduce, image, sigungu, isMember
        case leaderImage = "leader_image"
        case createdAt = "created_at"
        case members
    }
}



//이부분 테스트때매 만들었는데 윗부분 건드리기 애매해서 잠시 만들어놨습니다 ㅎㅎ
//SNS에 대한 구조체를 만든뒤  따로 빼서 쓸까 고민이 되는

struct StudyInfo {
    var image: UIImage
    var userID: Int
    var category: String
    var title: String
    var introduce: String
    var progress: String
    var studyTime: String
    var location: String
    var notion: String?
    var everNote: String?
    var web: String?
}
