//
//  MyStudyMainRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper

class MyStudyMainRemoteDataManager: MyStudyMainRemoteDataManagerProtocol {
    var interactor: MyStudyMainInteractorProtocol?
    
    func getMyStudyList(completion: @escaping (_: Bool, _: [MyStudy]?) -> Void) {
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.myStudyList(id: userID))
            .validate(statusCode: 200..<500)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    let result = try! JSONDecoder().decode(BaseResponse<[MyStudy]>.self, from: data!)
                    
                    completion(result.result, result.data)
                case .failure(let error):
                    print("error :", error )
                }
            }
    }
}
