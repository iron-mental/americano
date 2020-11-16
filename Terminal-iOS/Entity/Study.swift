//
//  Study.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

struct Study: Codable {
    let id: Int
    let title, introduce, image, sigungu: String?
    let leaderImage, createdAt: String?
    let members: Int?

    enum CodingKeys: String, CodingKey {
        case id, title, introduce, image, sigungu
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
    
//    "user_id" : studyInfo.userID,
//    "category" : studyInfo.category,
//    "title" : studyInfo.title,
//    "introduce" : studyInfo.introduce,
//    "progress" : studyInfo.progress,
//    "study_time" : studyInfo.studyTime,
//    "latitude" : studyInfo.notion,
//    "longitude" : studyInfo.everNote,
//    "region_1depth_name" : studyInfo.web,
//    "region_2depth_name" : studyInfo.location,
//    "address_name" : studyInfo.location,
//    "locaion_detail" : studyInfo.location,
//    "place_name" : studyInfo.location
//    "sns_notion" : ,
//    "sns_evernote" : ,
//    "sns_web" : ,
//    "image" :
}
