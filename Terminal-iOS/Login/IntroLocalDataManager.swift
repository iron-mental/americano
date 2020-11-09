//
//  IntroLocalDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/09.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class IntroLocalDataManager: IntroLocalDataManagerProtocol {
    static var shared = IntroLocalDataManager()
    
    var email = ""
    var password = ""
    var nickname =  ""
    
    func signUp(nickname: String) -> [String] {
        print(email)
        print(password)
        print(nickname)
//        guard let finalEmail = self.email, let finalPassword = self.password, let finalNickname = self.nickname else {
//            return []
            
//        }
        print(IntroLocalDataManager.shared.email, IntroLocalDataManager.shared.password, IntroLocalDataManager.shared.nickname)
        return [IntroLocalDataManager.shared.email, IntroLocalDataManager.shared.password, IntroLocalDataManager.shared.nickname]
    }
}
