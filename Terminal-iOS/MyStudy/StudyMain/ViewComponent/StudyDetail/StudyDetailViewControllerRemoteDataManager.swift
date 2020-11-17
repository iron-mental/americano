//
//  StudyDetailViewControllerRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/17.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class StudyDetailViewControllerRemoteDataManager: StudyDetailViewControllerRemoteDataManagerProtocol {
    func callStudyDetailInfoAPI(id: Int, completion: @escaping (Bool, StudyDetailInfo) -> ()) {
        
        TerminalAPI.getStudyDetailInfo(id: id) { (result, data) in
            switch result {
            case true:
                completion(result, data!)
                break
            case false:
                break
            }
        }
    }
    
    
}
