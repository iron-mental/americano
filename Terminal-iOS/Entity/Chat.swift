//
//  Chat.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/03/11.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

public class Chat: NSObject, Codable, NSCoding  {
    let studyID: Int
    let nickname: String
    let message: String
    let date: Int
    
    init(studyID: Int, nickname: String, message: String, date: Int) {
        self.studyID = studyID
        self.nickname = nickname
        self.message = message
        self.date = date
    }
    enum CodingKeys: String, CodingKey {
        case studyID = "study_id"
        case nickname, message, date
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(studyID, forKey: CodingKeys.studyID.rawValue)
        coder.encode(nickname, forKey: CodingKeys.nickname.rawValue)
        coder.encode(message, forKey: CodingKeys.message.rawValue)
        coder.encode(date, forKey: CodingKeys.date.rawValue)
    }
    
    public required convenience init?(coder: NSCoder) {
        let studyID = coder.decodeObject(forKey: CodingKeys.studyID.rawValue) as? Int ?? 0
        let nickname = coder.decodeObject(forKey: CodingKeys.nickname.rawValue) as? String ?? ""
        let message = coder.decodeObject(forKey: CodingKeys.message.rawValue) as? String ?? ""
        let date = coder.decodeObject(forKey: CodingKeys.date.rawValue) as? Int ?? 0
        
        self.init(studyID: studyID,
                  nickname: nickname,
                  message: message,
                  date: date)
    }
}

