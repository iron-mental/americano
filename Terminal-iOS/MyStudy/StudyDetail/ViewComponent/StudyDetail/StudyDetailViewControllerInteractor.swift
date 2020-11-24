//
//  StudyDetailViewControllerInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/17.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class StudyDetailViewControllerInteractor: StudyDetailViewControllerInteractorProtocol {
    var presenter: StudyDetailViewControllerPresenterProtocol?
    var remoteDataManager: StudyDetailViewControllerRemoteDataManagerProtocol?
    var localDataManager: StudyDetailViewControllerLocalDataManagerProtocol?
    
    
    func getStudyDetailInfo(study: MyStudy) {
        
        remoteDataManager?.callStudyDetailInfoAPI(id: study.id, completion: { [self] (result, data) in
            switch result {
            case true:
                presenter?.studyDetailInfoResult(result: result, studyInfo: data)
                break
            case false:
                print("false 떨어졌네용")
                break
            }
        })
    }
}
