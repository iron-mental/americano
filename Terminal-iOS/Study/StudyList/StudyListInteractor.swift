//
//  StudyListInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/14.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class StudyListInteractor: StudyListInteractorInputProtocol {
    var studyKeyArr: [Study] = []
    var lengthStudyKeyArr: [Study] = []
    var keyValue: [Int] = []
    var newKeyValue: [Int] = []
    var lengthNewKeyValue: [Int] = []
    
    var presenter: StudyListInteractorOutputProtocol?
    var localDataManager: StudyListLocalDataManagerInputProtocol?
    var remoteDataManager: StudyListRemoteDataManagerInputProtocol?
    
    func retrieveStudyList(category: String) {
        remoteDataManager?.retrieveStudyList(category: category)
        remoteDataManager?.retrieveLengthStudyList(category: category)
    }
    
    /// 최신순 스터디 리스트 페이징
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
        
        remoteDataManager?.paginationRetrieveStudyList(keyValue: newKeyValue, completion: {
            self.newKeyValue.removeAll()
        })
    }
    
    /// 지역순 스터디 리스트 페이징
    func pagingRetrieveLengthStudyList() {
        /// 스터디 키값이 10개가 넘을경우
        if lengthStudyKeyArr.count >= 10 {
            for _ in 0..<10 {
                lengthNewKeyValue.append(lengthStudyKeyArr[0].id)
                lengthStudyKeyArr.remove(at: 0)
            }
        } else {
            for _ in 0..<lengthStudyKeyArr.count {
                lengthNewKeyValue.append(lengthStudyKeyArr[0].id)
                lengthStudyKeyArr.remove(at: 0)
            }
        }
        
        remoteDataManager?.paginationRetrieveStudyList(keyValue: lengthNewKeyValue, completion: {
            self.lengthNewKeyValue.removeAll()
        })
    }  
}

extension StudyListInteractor: StudyListRemoteDataManagerOutputProtocol {
    func onStudiesRetrieved(studies: BaseResponse<[Study]>) {
        var resultArr: [Study] = []
        var studyArr: [Study] = []
        
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
        
        presenter?.didRetrieveStudies(studies: studyArr)
    }
    
    func onStudiesLengthRetrieved(studies: BaseResponse<[Study]>) {
        var resultArr: [Study] = []
        var studyArr: [Study] = []
        
        if studies.result {
            guard let studyList = studies.data else { return }
            for study in studyList {
                resultArr.append(study)
            }
            
            /// 키값만 내려오는 배열
            for data in resultArr {
                if data.title == nil {
                    lengthStudyKeyArr.append(data)
                }
            }
            
            /// 모든 데이터가 내려오는 배열
            for data in resultArr {
                if data.title != nil {
                    studyArr.append(data)
                }
            }
        }
        presenter?.didRetrieveLengthStudies(studies: studyArr)
    }
    
    func onError() {
        
    }
}
