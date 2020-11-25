//
//  StudyListInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/14.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class StudyListInteractor: StudyListInteractorInputProtocol {
    var studyArr: [Study] = []
    var studyKeyArr: [Study] = []
    var keyValue: [Int] = []
    var newKeyValue: [Int] = []
    
    var presenter: StudyListInteractorOutputProtocol?
    var localDataManager: StudyListLocalDataManagerInputProtocol?
    var remoteDataManager: StudyListRemoteDataManagerInputProtocol?
    
    func retrieveStudyList(category: String) {
        remoteDataManager?.retrieveStudyList(category: category)
    }
    
    func pagingRetrieveStudyList() {
        /// 스터디 키값이 10개가 넘을경우
        if studyKeyArr.count >= 10 {
            for _ in 0..<10 {
                newKeyValue.append(studyKeyArr[0].id)
                studyKeyArr.remove(at: 0)
            }
        } else {
            for _ in 0..<studyKeyArr.count {
                newKeyValue.append(studyKeyArr[0].id)
                studyKeyArr.remove(at: 0)
            }
        }
        
        remoteDataManager?.paginationRetrieveStudyList(keyValue: newKeyValue)
        
        newKeyValue.removeAll()
    }
}

extension StudyListInteractor: StudyListRemoteDataManagerOutputProtocol {
    func onStudiesRetrieved(_ studies: BaseResponse<[Study]>) {
        var resultArr: [Study] = []
        
        if studies.result {
            guard let studyList = studies.data else { return }
            for study in studyList {
                resultArr.append(study)
            }
            
            /// 키값만 내려오는 배열
            for data in resultArr {
                if data.title == nil {
                    studyKeyArr.append(data)
                }
            }
            
            /// 모든 데이터가 내려오는 배열
            for data in resultArr {
                if data.title != nil {
                    studyArr.append(data)
                }
            }
        }
        
        presenter?.didRetrieveStudies(studyArr)
    }
    
    func onError() {
        
    }
}
