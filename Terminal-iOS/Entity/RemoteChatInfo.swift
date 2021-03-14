//
//  RemoteChatInfo.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/03/14.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

struct RemoteChatInfo: Codable {
    let chatList: [Chat]
    let userList: [ChatParticipate]

    enum CodingKeys: String, CodingKey {
        case chatList = "chat"
        case userList = "user_list"
    }
}
