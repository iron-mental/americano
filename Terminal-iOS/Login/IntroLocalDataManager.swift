//
//  IntroLocalDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/09.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

final class IntroLocalDataManager: IntroLocalDataManagerProtocol {
    static var shared = IntroLocalDataManager()
    
    var email = ""
    var password = ""
    var nickname =  ""
    
    func signUp(nickname: String) -> [String] {
        return [IntroLocalDataManager.shared.email, IntroLocalDataManager.shared.password, IntroLocalDataManager.shared.nickname]
    }
}
