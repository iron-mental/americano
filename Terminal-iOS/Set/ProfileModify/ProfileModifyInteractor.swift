//
//  ProfileModifyInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class ProfileModifyInteractor: ProfileModifyInteractorInputProtocol {
    var presenter: ProfileModifyInteractorOutputProtocol?
    var remoteDataManager: ProfileModifyRemoteDataManagerInputProtocol?
    
    var remoteProjectList: [Project] = []
    
    
    func completeModify(userInfo: UserInfoPut, project: [Project]) {
        remoteDataManager?.validProfileModify(userInfo: userInfo)
        
        // 리모트 데이터 받아옴
        remoteDataManager?.remoteProjectList(completion: { result in
            self.remoteProjectList = result
        })
        
        remoteDataManager?.remoteProjectList(completion: { result in
            print("삭제 여부:",result)
        })
        
        for data in project {
            remoteDataManager?.registerProject(project: data)
        }   
    }
}

extension ProfileModifyInteractor: ProfileModifyRemoteDataManagerOutputProtocol {
    
}
