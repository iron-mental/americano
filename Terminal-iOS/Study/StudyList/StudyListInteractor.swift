//
//  StudyListInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/14.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class StudyListInteractor: StudyListInteractorInputProtocol {
    var presenter: StudyListInteractorOutputProtocol?
    var localDataManager: StudyListLocalDataManagerInputProtocol?
    var remoteDataManager: StudyListRemoteDataManagerInputProtocol?
    
    func retrieveStudyList() {
//        remoteDataManager?.retrieveStudyList(completionHandler: { [self] in
//            presenter?.didRetrieveStudies($0)
//        })
//        remoteDataManager?.retrieveStudyList(category: "IOS", sort: "new", completionHandler: { [self] in
//            presenter?.didRetrieveStudies($0)
//        })
//        
        remoteDataManager?.paginationRetrieveStudyList(keyValue: "12,11,10,9,8,7,6,5,3,2", completionHandler: { [self] in
            presenter?.didRetrieveStudies($0)
        })
    }
}

extension StudyListInteractor: StudyListRemoteDataManagerOutputProtocol {
    func onStudiesRetrieved(_ studies: [Study]) {
        presenter?.didRetrieveStudies(studies)
    }
    
    func onError() {
        
    }
}
