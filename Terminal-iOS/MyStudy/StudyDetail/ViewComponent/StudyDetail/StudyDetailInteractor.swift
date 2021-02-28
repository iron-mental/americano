//
//  StudyDetailInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/13.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

final class StudyDetailInteractor: StudyDetailInteractorInputProtocol {
    weak var presenter: StudyDetailInteractorOutputProtocol?
    var localDatamanager: StudyDetailLocalDataManagerInputProtocol?
    var remoteDatamanager: StudyDetailRemoteDataManagerInputProtocol?
    
    func retrieveStudyDetail(studyID: String) {
        remoteDatamanager?.getStudyDetail(studyID: studyID)
    }
    
    func postStudyJoin(studyID: Int, message: String) {
        remoteDatamanager?.postStudyJoin(studyID: studyID, message: message)
    }
}

extension StudyDetailInteractor: StudyDetailRemoteDataManagerOutputProtocol {
    func onStudyDetailRetrieved(result: BaseResponse<StudyDetailInfo>) {
        switch result.result {
        case true:
            guard let studyInfo = result.data?.studyInfo else { return }
            presenter?.didRetrieveStudyDetail(convertStudyDetail(studyDetail: studyInfo))
        case false:
            guard let msg = result.message else { return }
            presenter?.onError(message: msg)
        }
        
    }
    
    func postStudyJoinResult(result: BaseResponse<String>) {
        guard let message = result.message else { return }
        presenter?.studyJoinResult(result: result.result, message: message)
    }
    
    func convertStudyDetail(studyDetail: StudyDetail) -> StudyDetail {
        let convertedStudyDetail = StudyDetail(participate: studyDetail.participate,
                                               id: studyDetail.id,
                                               category: studyDetail.category,
                                               title: studyDetail.title,
                                               introduce: studyDetail.introduce,
                                               progress: studyDetail.progress,
                                               studyTime: studyDetail.studyTime,
                                               snsWeb: convertSNS(sns: studyDetail.snsWeb),
                                               snsNotion: convertSNS(sns: studyDetail.snsNotion),
                                               snsEvernote: convertSNS(sns: studyDetail.snsEvernote),
                                               image: studyDetail.image,
                                               location: studyDetail.location,
                                               authority: studyDetail.authority)
        return convertedStudyDetail
    }
    
    func convertSNS(sns: String?) -> String {
        if sns == nil {
            return ""
        } else {
            return sns!
        }
    }
}
