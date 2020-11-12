//
//  StudyListRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class StudyListRemoteDataManager: StudyListRemoteDataManagerInputProtocol {
    var remoteRequestHandler: StudyListRemoteDataManagerOutputProtocol?
    var studyArr: [Study] = []
    func retrieveStudyList(category: String, sort: String ,completionHandler: @escaping (([Study])) -> ()) {
        TerminalNetwork.getNewStudyList(category, sort) { completionHandler($0) }
    }
    
    func paginationRetrieveStudyList(keyValue: String, completionHandler: @escaping (([Study])) -> ()) {
        TerminalNetwork.getNewStudyListForKey(keyValue) { completionHandler($0) }
    }
}
