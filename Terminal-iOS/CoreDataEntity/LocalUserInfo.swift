//
//  LocalUserInfo.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import CoreData

public class LocalUserInfo: NSObject, NSCoding {
    let id: Int
    let nickname, email: String
    let image, introduce: String?
    let careerTitle, careerContents: String?
    let sido, sigungu: String?
    let snsLinkedin, snsWeb, snsGithub: String?
    let emailVerified: Bool
    let createdAt: String
    
    enum Keys: String {
        case id,
             nickname,
             email,
             image,
             introduce,
             sido,
             sigungu,
             careerTitle,
             careerContents,
             snsLinkedin,
             snsWeb,
             snsGithub,
             emailVerified,
             createdAt
    }
    init(userInfo: UserInfo) {
        self.id = userInfo.id
        self.nickname = userInfo.nickname
        self.email = userInfo.email
        self.image = userInfo.image
        self.introduce = userInfo.introduce
        self.sido = userInfo.sido
        self.sigungu = userInfo.sigungu
        self.careerTitle = userInfo.careerTitle
        self.careerContents = userInfo.careerContents
        self.snsLinkedin = userInfo.snsLinkedin
        self.snsWeb = userInfo.snsWeb
        self.snsGithub = userInfo.snsGithub
        self.emailVerified = userInfo.emailVerified
        self.createdAt = userInfo.createdAt
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: Keys.id.rawValue)
        coder.encode(nickname, forKey: Keys.nickname.rawValue)
        coder.encode(email, forKey: Keys.email.rawValue)
        coder.encode(image, forKey: Keys.image.rawValue)
        coder.encode(introduce, forKey: Keys.introduce.rawValue)
        coder.encode(sido, forKey: Keys.sido.rawValue)
        coder.encode(sigungu, forKey: Keys.sigungu.rawValue)
        coder.encode(careerTitle, forKey: Keys.careerTitle.rawValue)
        coder.encode(careerContents, forKey: Keys.careerContents.rawValue)
        coder.encode(snsLinkedin, forKey: Keys.snsLinkedin.rawValue)
        coder.encode(snsWeb, forKey: Keys.snsWeb.rawValue)
        coder.encode(snsGithub,forKey: Keys.snsGithub.rawValue)
        coder.encode(emailVerified, forKey: Keys.emailVerified.rawValue)
        coder.encode(createdAt, forKey: Keys.createdAt.rawValue)
    }
    
    public required convenience init?(coder decoder: NSCoder) {
        let decodedUserInfo = UserInfo(id: Int(decoder.decodeInt64(forKey: Keys.id.rawValue)),
                 nickname: decoder.decodeObject(forKey: Keys.nickname.rawValue) as? String ?? "",
                 email: decoder.decodeObject(forKey: Keys.email.rawValue) as? String ?? "",
                 image: decoder.decodeObject(forKey: Keys.image.rawValue) as? String ?? "",
                 introduce: decoder.decodeObject(forKey: Keys.introduce.rawValue) as? String ?? "",
                 sido: decoder.decodeObject(forKey: Keys.sido.rawValue) as? String ?? "",
                 sigungu: decoder.decodeObject(forKey: Keys.sigungu.rawValue) as? String ?? "",
                 careerTitle: decoder.decodeObject(forKey: Keys.careerTitle.rawValue) as? String ?? "",
                 careerContents: decoder.decodeObject(forKey: Keys.careerContents.rawValue) as? String ?? "",
                 snsLinkedin: decoder.decodeObject(forKey: Keys.snsLinkedin.rawValue) as? String ?? "",
                 snsWeb: decoder.decodeObject(forKey: Keys.snsWeb.rawValue) as? String ?? "",
                 snsGithub: decoder.decodeObject(forKey: Keys.snsGithub.rawValue) as? String ?? "",
                 emailVerified: decoder.decodeBool(forKey: Keys.emailVerified.rawValue),
                 createdAt: decoder.decodeObject(forKey: Keys.createdAt.rawValue) as? String ?? "")
        self.init(userInfo: decodedUserInfo)
    }
}
