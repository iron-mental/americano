//
//  ModifyStudyInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/19.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class ModifyStudyInteractor: ModifyStudyInteractorInputProtocol {
    var presenter: ModifyStudyInteractorOutputProtocol?
    var remoteDataManager: ModifyStudyRemoteDataManagerInputProtocol?
    var currentStudy: StudyDetail?
    
    func nullCheck(study: StudyDetailPost) -> String {
        if study.category.isEmpty {
            return "카테고리 비어있음"
        } else if study.title.isEmpty {
            return "제목 비어있음"
        } else if study.introduce.isEmpty {
            return "소개 비어있음"
        } else if study.progress!.isEmpty {
            return "진행 비어있음"
        } else if study.studyTime!.isEmpty {
            return "시간 비어있음"
        } else if study.location == nil {
            return "장소를 선택해주세요"
        } else if let location = study.location {
            if location.lat.isZero {
                return "장소를 선택해주세요 - latitude error"
            } else if location.lng.isZero {
                return "장소를 선택해주세요 - latitude error"
            } else if location.sido.isEmpty {
                return "장소를 선택해주세요 - sido 비어있음"
            } else if location.sigungu.isEmpty {
                return "장소를 선택해주세요 - sigungu 비어있음"
            } else if location.address.isEmpty {
                return "장소를 선택해주세요 - address 비어있음"
            }
        } else {
            return "성공"
        }
        return "실패요"
    }
    
    func duplicateCheck(targetStudy: StudyDetailPost) -> StudyDetailPost{
        
        let resultStudy = StudyDetailPost(category: currentStudy?.category == targetStudy.category ? "" : targetStudy.category,
                                          title:  currentStudy?.title == targetStudy.title ? "" : targetStudy.title,
                                          introduce:  currentStudy?.introduce == targetStudy.introduce ? "" : targetStudy.introduce,
                                          progress:  currentStudy?.progress == targetStudy.progress ? "" : targetStudy.progress,
                                          studyTime:  currentStudy?.studyTime == targetStudy.studyTime ? "" : targetStudy.studyTime,
                                          snsWeb:  currentStudy?.snsWeb == targetStudy.snsWeb ? "" : targetStudy.snsWeb,
                                          snsNotion:  currentStudy?.snsNotion == targetStudy.snsNotion ? "" : targetStudy.snsNotion,
                                          snsEvernote:  currentStudy?.snsEvernote == targetStudy.snsEvernote ? "" : targetStudy.snsEvernote,
                                          image: nil,
                                          location: targetStudy.location)
        
        return resultStudy
    }
    func putStudyInfo(studyID: Int, study: StudyDetailPost) {
        
        print(nullCheck(study: study))
        if nullCheck(study: study) == "성공" {
            
            remoteDataManager?.putStudyInfo(studyID: studyID, study: duplicateCheck(targetStudy: study))
            
        } else {
            print("ModifyStudyInteractor에서 생긴 에러")
        }
    }
}

extension ModifyStudyInteractor: ModifyStudyRemoteDataManagerOutputProtocol {
    func putStudyInfoResult(result: Bool, message: String) {
        switch result {
        case true:
            presenter?.putStudyInfoResult(result: result, message: message)
            break
        case false:
            presenter?.putStudyInfoResult(result: result, message: message)
            break
        }
    }
}
