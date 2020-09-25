//
//  CreateStudyRemoteManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class CreateStudyRemoteManager: CreateStudyRemoteDataManagerProtocols {
    func getNotionValid(id: String?) -> Bool {
        return true
    }
    
    func getEvernoteValid(url: String?) -> Bool{
        return true
    }
    
    func getWebValid(url: String?) -> Bool{
        return true
    }
}
