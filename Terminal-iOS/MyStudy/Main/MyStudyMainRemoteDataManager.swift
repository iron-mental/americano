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
    
    func getMyStudyList(completion: @escaping (_: Bool, _: MyStudyList?) -> Void) {
        
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.myStudyList(id: userID))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<MyStudyList>.self, from: data!)
                        completion(result.result, result.data)
                    } catch {
                    }
                case .failure(let error):
                    print("error :", error )
                }
            }
    }
}
