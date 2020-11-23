////
////  StudyDetailInfo.swift
////  Terminal-iOS
////
////  Created by 정재인 on 2020/11/18.
////  Copyright © 2020 정재인. All rights reserved.
////
//
//import Foundation
//
//struct StudyDetailInfo: Codable {
//    let result: Bool
//    let data: DataClass
//}
//
//// MARK: - DataClass
//struct DataClass: Codable {
//    let participate: [Participate]
//    let id: Int
//    let category, title, introduce, image: String
//    let progress, studyTime: String
//    let snsNotion, snsEvernote, snsWeb: String?
//    let location: Location
//    let authority: String
//    
//    enum CodingKeys: String, CodingKey {
//        case participate, id, category, title, introduce, image, progress
//        case studyTime = "study_time"
//        case snsNotion = "sns_notion"
//        case snsEvernote = "sns_evernote"
//        case snsWeb = "sns_web"
//        case location
//        case authority = "Authority"
//    }
//}
//
//// MARK: - Location
//struct Location: Codable {
//    let latitude, longitude, addressName: String
//    let placeName, locationDetail: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case latitude, longitude
//        case addressName = "address_name"
//        case placeName = "place_name"
//        case locationDetail = "location_detail"
//    }
//}
//
//// MARK: - Participate
//struct Participate: Codable {
//    let id, userID: Int
//    let nickname: String
//    let image: String?
//    let leader: Bool
//    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case userID = "user_id"
//        case nickname, image, leader
//    }
//}
