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
        
        /// 서버의 내 프로젝트 데이터 받아옴
        remoteDataManager?.remoteProjectList(completion: { [self] result in
            if let tempProject = result.data  {
                /// 임시 프로젝트 변수에 저장
                self.remoteProjectList = tempProject
                
                if self.remoteProjectList.count > 0 {
                    /// 서버에 프로젝트가 있음
                    /// 프로젝트 모두 삭제
                    for data in self.remoteProjectList {
                        guard let id = data.id else { return }
                        
                        /// 프로젝트의 ID 추출해서 다 삭제
                        self.remoteDataManager?.removeProject(projectID: id, completion: { _ in })
                    }
                    
                    for data in project {
                        self.remoteDataManager?.registerProject(project: data)
                    }
                } else {
                    /// 서버에 프로젝트가 없음
                    for data in project {
                        self.remoteDataManager?.registerProject(project: data)
                    }
                }
            }
        })
    }
}

extension ProfileModifyInteractor: ProfileModifyRemoteDataManagerOutputProtocol {
    
}
