//
//  StudyCategoryRemoteManager.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import SwiftyJSON

class StudyCategoryRemoteManager: StudyCategoryRemoteDataManagerInputProtocol {
    var interactor: StudyCategoryRemoteDataManagerOutputProtocol?
    
    func retrievePostList() {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.studyCategory)
            .validate(statusCode: 200..<500)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    let result = try! JSONDecoder().decode(BaseResponse<[String]>.self, from: data!)
                    self.interactor?.onCategoriesRetrieved(categories: result)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
