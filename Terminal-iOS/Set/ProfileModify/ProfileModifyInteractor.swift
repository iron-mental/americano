//
//  ProfileModifyInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class ProfileModifyInteractor: ProfileModifyInteractorInputProtocol {
    
    
    var presenter: ProfileModifyInteractorOutputProtocol?
    var remoteDataManager: ProfileModifyRemoteDataManagerInputProtocol?
    
    var remoteProjectList: [Project] = []
    
    func validParams(project: [Project]) {
        for data in project {
            if !data.snsGithub!.isEmpty {
                
            }
        }
    }
    
    func viewDidLoad() {
        remoteDataManager?.authCheck {
        }
    }
    
    func completeModify(userInfo: UserInfoPut, project: [Project]) {
        remoteDataManager?.validProfileModify(userInfo: userInfo)
        
        
            
            /// 서버의 내 프로젝트 데이터 받아옴
//            self.remoteDataManager?.remoteProjectList(completion: { result in
//                if result.result {
//                    if let projectList = result.data  {
//                        /// 임시 프로젝트 변수에 저장
//                        self.remoteProjectList = projectList
//
//                        if self.remoteProjectList.count > 0 {
//                            /// 서버에 프로젝트가 있음
//                            /// 프로젝트 모두 삭제
//                            for data in self.remoteProjectList {
//                                guard let id = data.id else { return }
//
//                                /// 프로젝트의 ID 추출해서 다 삭제
//                                self.remoteDataManager?.removeProject(projectID: id, completion: { _ in })
//                            }
//
//                            for data in project {
//                                var params: [String: String] = [
//                                    "title": data.title,
//                                    "contents": data.contents
//                                ]
//
//                                if !data.snsGithub!.isEmpty {
//                                    params.updateValue(data.snsGithub!, forKey: "sns_github")
//                                }
//                                if !data.snsAppstore!.isEmpty {
//                                    params.updateValue(data.snsAppstore!, forKey: "sns_appstore")
//                                }
//                                if !data.snsPlaystore!.isEmpty {
//                                    params.updateValue(data.snsPlaystore!, forKey: "sns_playstore")
//                                }
//
//                                self.remoteDataManager?.registerProject(project: params)
//                            }
//                        }
//                    }
//                } else {
//                    for data in project {
//                        var params: [String: String] = [
//                            "title": data.title,
//                            "contents": data.contents
//                        ]
//
//                        if !data.snsGithub!.isEmpty {
//                            params["sns_github"] = data.snsGithub!
//                        }
//                        if !data.snsAppstore!.isEmpty {
//                            params["sns_appstore"] = data.snsAppstore!
//                        }
//                        if !data.snsPlaystore!.isEmpty {
//                            params["sns_playstore"] = data.snsPlaystore!
//                        }
//
//                        self.remoteDataManager?.registerProject(project: params)
//                    }
//                }
//            })
        
        
    }
}

extension ProfileModifyInteractor: ProfileModifyRemoteDataManagerOutputProtocol {
    
}
