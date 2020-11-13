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
    var studyKeyArr: [Study] = []
    var keyValue: [Int] = []
    var newKeyValue: [Int] = []
    func retrieveStudyList(category: String, sort: String ,completionHandler: @escaping (([Study])) -> ()) {
        TerminalNetwork.getNewStudyList(category, sort) {
            for data in $0 {
                if data.title == nil {
                    self.studyKeyArr.append(data)
                }
            }
            
            for data in $0 {
                if data.title != nil {
                    self.studyArr.append(data)
                }
            }
            
            completionHandler(self.studyArr)
        }
    }
    
    func paginationRetrieveStudyList(completionHandler: @escaping (([Study])) -> ()) {
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
        
        if newKeyValue.count > 0 {
            TerminalNetwork.getNewStudyListForKey(newKeyValue) { completionHandler($0) }
        }
        newKeyValue.removeAll()
    }
}
