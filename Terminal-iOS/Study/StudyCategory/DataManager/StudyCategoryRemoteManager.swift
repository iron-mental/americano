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
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<[String]>.self, from: data!)
                        self.interactor?.onCategoriesRetrieved(result: result)
                    } catch {
                        print(error)
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<[String]>.self, from: data)
                            self.interactor?.onError()
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
    }
}
