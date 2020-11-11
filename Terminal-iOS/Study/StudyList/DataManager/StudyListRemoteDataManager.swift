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
    func retrieveStudyList(completionHandler: @escaping (([Study])) -> ()) {
        let url = "http://3.35.154.27:3000/v1/study?category=IOS&sort=new"
        AF.request(url).responseJSON { [self] response in
            switch response.result {
            case .success(let value):
                if let data = JSON(value)["data"].array {
                    do {
                        for index in data {
                            if index["title"].string != nil {
                                print(index)
                                let temp = try Study(title: index["title"].string!, subTitle: index["introduce"].string!, location: "강남구", date: index["created_at"].string!, managerImage: UIImage(named: "leehi")!, mainImage: UIImage(named: "mainImage")!)
                                self.studyArr.append(temp)
                            }
                        }
                        completionHandler(studyArr)
                    } catch {
                        print("error")
                    }
                    
                }
            case .failure(let err):
                print(err)
            }
        }
        
    }
}
