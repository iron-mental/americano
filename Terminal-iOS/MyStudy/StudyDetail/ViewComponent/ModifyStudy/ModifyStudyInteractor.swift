//
//  ModifyStudyInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/19.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class ModifyStudyInteractor: ModifyStudyInteractorInputProtocol {
    weak var presenter: ModifyStudyInteractorOutputProtocol?
    var remoteDataManager: ModifyStudyRemoteDataManagerInputProtocol?
    var currentStudy: StudyDetail?
    
    func nilCheck(study: StudyDetailPost) -> StudyNilCheck {
        var nilCheck: StudyNilCheck?
        
        if study.category.isEmpty {
            nilCheck = StudyNilCheck(message: "카테고리가 지정되어있지 않습니다.", label: "category")
        } else if study.title!.isEmpty {
            nilCheck = StudyNilCheck(message: "제목을 입력해주세요", label: "title")
        } else if study.introduce!.isEmpty {
            nilCheck = StudyNilCheck(message: "소개를 입력해주세요", label: "introduce")
        } else if study.progress!.isEmpty {
            nilCheck = StudyNilCheck(message: "진행을 입력해주세요", label: "progress")
        } else if study.studyTime!.isEmpty {
            nilCheck = StudyNilCheck(message: "시간을 입력해주세요", label: "studyTime")
        } else if let notion = study.snsNotion {
            if !notion.notionCheck() {
                nilCheck = StudyNilCheck(message: "Notion URL이 정확하지 않습니다.", label: "sns_notion")
            } else if let evernote = study.snsEvernote {
                if !evernote.evernoteCheck() {
                    nilCheck = StudyNilCheck(message: "Evernote URL이 정확하지 않습니다.", label: "sns_evernote")
                } else if let web = study.snsWeb {
                    if !web.webCheck() {
                        nilCheck = StudyNilCheck(message: "web URL이 정확하지 않습니다.", label: "sns_web")
                    }
                }
            }
        } else if let location = study.location {
            if location.lat.isZero
                || location.lng.isZero
                || location.sido!.isEmpty
                || location.sigungu!.isEmpty
                || location.address.isEmpty {
                nilCheck = StudyNilCheck(message: "장소를 선택해주세요.", label: "locaion_detail")
            }
        }
        
        if let nilCheck = nilCheck {
            return nilCheck
        } else {
            return StudyNilCheck(message: "성공", label: nil)
        }
    }
    
    
    func duplicateCheck(targetStudy: StudyDetailPost) -> StudyDetailPost {
        let resultStudy = StudyDetailPost(category: targetStudy.category,
                                          title: currentStudy?.title ==
                                            targetStudy.title
                                            ? nil
                                            : targetStudy.title,
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
        let nilCheckResult = nilCheck(study: study)
        if nilCheckResult.message == "성공" {
            remoteDataManager?.putStudyInfo(studyID: studyID, study: duplicateCheck(targetStudy: study))
        } else {
            let label = nilCheckResult.label
            let message = nilCheckResult.message
            presenter?.putStudyInfoResult(result: false, label: label, message: message)
        }
    }
}

extension ModifyStudyInteractor: ModifyStudyRemoteDataManagerOutputProtocol {
    func putStudyInfoResult(result: BaseResponse<String>) {
        self.presenter?.putStudyInfoResult(result: result.result,
                                           label: result.label,
                                           message: result.message ?? "")
    }
}
