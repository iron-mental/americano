//
//  Study.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

// MARK: 스터디 리스트

struct Study: Codable {
    let id: Int
    let title, introduce, image, sigungu: String?
    let leaderImage: String?
    let createdAt: Int?
    let memberCount: Int?
    let distance: Double?
    let isMember: Bool?
    let isPaging: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, title, introduce, image, sigungu
        case distance
        case isMember = "is_member"
        case leaderImage = "leader_image"
        case createdAt = "created_at"
        case memberCount = "member_count"
        case isPaging = "is_paging"
    }
}

public class TestStudyList: NSObject, NSCoding {
    public var testList: [TestStudy] = []
    
    enum Key: String {
        case testList
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
    public var id = 0
    
    enum Key: String {
        case id
    }
    init(id: Int) {
        self.id = id
    }
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: Key.id.rawValue)
    }
    public required convenience init?(coder: NSCoder) {
        if let studyID = coder.decodeObject(forKey: Key.id.rawValue) {
            self.init(id: studyID as! Int)
        } else {
            self.init(id: 1)
        }
    }
}
