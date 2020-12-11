//
//  Study.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

//MARK : 스터디 리스트

//struct StudyList: Codable {
//    let result: Bool
//    let data: [Study]
//}

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

public class TestStudyList: NSObject, NSCoding {

    public var testList: [TestStudy] = []
    
    enum Key: String {
        case testList = "testList"
    }
    init(list: [TestStudy]) {
        self.testList = list
    }
    public func encode(with coder: NSCoder) {
        coder.encode(testList, forKey: Key.testList.rawValue)
    }
    
    public required convenience init?(coder: NSCoder) {
        let list = coder.decodeObject(forKey: Key.testList.rawValue) as! [TestStudy]
        
        self.init(list: list)
    }
}

public class TestStudy: NSObject, NSCoding {
//    public var testStudy: TestStudy?
    public var id = 0
    
    enum Key: String {
        case id = "id"
    }
    init(id: Int) {
        self.id = id
    }
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: Key.id.rawValue)
    }
    public required convenience init?(coder: NSCoder) {
        let studyID = coder.decodeObject(forKey: Key.id.rawValue)
        
        self.init(id: studyID as! Int)
    }
}
