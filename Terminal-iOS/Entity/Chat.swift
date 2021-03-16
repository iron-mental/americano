//
//  Chat.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/03/11.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

public class Chat: NSObject, Codable, NSCoding {
    let uuid: String?
    let studyID: Int
    let userID: Int
    var nickname: String?
    let message: String?
    let date: Int
    var isTemp: Bool?
    
    init(uuid: String?, studyID: Int, userID: Int, nickname: String?, message: String?, date: Int, isTemp: Bool?) {
        self.uuid = uuid
        self.studyID = studyID
        self.userID = userID
        self.nickname = nickname
        self.message = message
        self.date = date
        self.isTemp = isTemp
    }
    enum CodingKeys: String, CodingKey {
        case studyID = "study_id"
        case userID = "user_id"
        case nickname, message, date, uuid, isTemp
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(uuid, forKey: CodingKeys.uuid.rawValue)
        coder.encode(studyID, forKey: CodingKeys.studyID.rawValue)
        coder.encode(userID, forKey: CodingKeys.userID.rawValue)
        coder.encode(nickname, forKey: CodingKeys.nickname.rawValue)
        coder.encode(message, forKey: CodingKeys.message.rawValue)
        coder.encode(date, forKey: CodingKeys.date.rawValue)
        coder.encode(isTemp, forKey: CodingKeys.isTemp.rawValue)
    }
    
    public required convenience init?(coder: NSCoder) {
        let uuid = coder.decodeObject(forKey: CodingKeys.uuid.rawValue) as? String ?? nil
        let studyID = coder.decodeInteger(forKey: CodingKeys.studyID.rawValue)
        let userID = coder.decodeInteger(forKey: CodingKeys.userID.rawValue)
        let nickname = coder.decodeObject(forKey: CodingKeys.nickname.rawValue) as? String ?? nil
        let message = coder.decodeObject(forKey: CodingKeys.message.rawValue) as? String ?? nil
        let date = coder.decodeInteger(forKey: CodingKeys.date.rawValue)
        let isTemp = coder.decodeBool(forKey: CodingKeys.isTemp.rawValue)

        self.init(uuid: uuid,
                  studyID: studyID,
                  userID: userID,
                  nickname: nickname,
                  message: message,
                  date: date,
                  isTemp: isTemp)
    }
}
