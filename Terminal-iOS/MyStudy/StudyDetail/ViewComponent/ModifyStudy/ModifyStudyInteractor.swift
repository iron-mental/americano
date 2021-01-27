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
            return "카테고리가 지정되어있지 않습니다."
        } else if study.title!.isEmpty {
            return "제목을 입력해주세요"
        } else if study.introduce!.isEmpty {
            return "소개를 입력해주세요"
        } else if study.progress!.isEmpty {
            return "진행을 입력해주세요"
        } else if study.studyTime!.isEmpty {
            return "시간을 입력해주세요"
        } else if study.location == nil {
            return "장소를 선택해주세요"
        } else if let notion = study.snsNotion {
            if !notion.notionCheck() {
                return "Notion URL이 정확하지 않습니다."
            } else if let evernote = study.snsEvernote {
                if !evernote.evernoteCheck() {
                    return "Evernote URL이 정확하지 않습니다."
                } else if let web = study.snsWeb {
                    if !web.webCheck() {
                        return "Web URL이 정확하지 않습니다."
                    }
                }
            }
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
        }
        return "성공"
    }
    
    
    func duplicateCheck(targetStudy: StudyDetailPost) -> StudyDetailPost {
        let resultStudy = StudyDetailPost(category: targetStudy.category,
                                          title: currentStudy?.title == targetStudy.title ? nil : targetStudy.title,
                                          introduce: targetStudy.introduce,
                                          progress: targetStudy.progress,
                                          studyTime: targetStudy.studyTime,
                                          snsWeb: targetStudy.snsWeb,
                                          snsNotion: targetStudy.snsNotion,
                                          snsEvernote: targetStudy.snsEvernote,
                                          image: targetStudy.image,
                                          location: targetStudy.location)
        return resultStudy
    }

    
    func putStudyInfo(studyID: Int, study: StudyDetailPost) {
        
        print(nullCheck(study: study))
        if nullCheck(study: study) == "성공" {
            remoteDataManager?.putStudyInfo(studyID: studyID, study: duplicateCheck(targetStudy: study))
//            remoteDataManager?.putStudyInfo(studyID: studyID, study: study)
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
