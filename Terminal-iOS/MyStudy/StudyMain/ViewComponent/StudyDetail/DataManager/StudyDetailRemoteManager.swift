//
//  StudyDetailRemoteManager.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/13.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class StudyDetailRemoteManager: StudyDetailRemoteDataManagerInputProtocol {
    var remoteRequestHandler: StudyDetailRemoteDataManagerOutputProtocol?
    
    func retrievePostList(keyValue: String, completionHandler: @escaping (StudyDetail) -> ()) {
        TerminalNetwork.getStudyDetail(keyValue) {
            completionHandler($0)
        }
    }
}
