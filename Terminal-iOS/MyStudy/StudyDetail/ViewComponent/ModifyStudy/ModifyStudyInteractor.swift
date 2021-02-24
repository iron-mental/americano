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
        let nilCheckResult = StudyCheck.execute(study: study)
        
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
