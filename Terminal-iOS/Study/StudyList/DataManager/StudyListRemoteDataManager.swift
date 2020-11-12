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
    var keyValue: [Int] = []
    var oldKeyValue: [Int] = []
    var newKeyValue: [Int] = []
    func retrieveStudyList(category: String, sort: String ,completionHandler: @escaping (([Study])) -> ()) {
        TerminalNetwork.getNewStudyList(category, sort) { completionHandler($0)} completion: {
            self.keyValue = $0
        }
    }
    
    func paginationRetrieveStudyList(completionHandler: @escaping (([Study])) -> ()) {
        if keyValue.count >= 10 {
            for i in 0..<10 {
                newKeyValue.append(keyValue[0])
                keyValue.remove(at: 0)
            }
        } else {
            for i in 0..<keyValue.count{
                newKeyValue.append(keyValue[0])
                keyValue.remove(at: 0)
            }
        }
        
        if newKeyValue.count > 0 {
            TerminalNetwork.getNewStudyListForKey(newKeyValue) { completionHandler($0) }
        }
        newKeyValue.removeAll()
    }
}
