//
//  MyStudyMainRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class MyStudyMainRemoteDataManager: MyStudyMainRemoteDataManagerProtocol {
    weak var interactor: MyStudyMainInteractorProtocol?
    
    func getMyStudyList(completion: @escaping (_: BaseResponse<MyStudyList>) -> Void) {
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.myStudyList(id: userID))
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<MyStudyList>.self, from: data)
                        completion(result)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<MyStudyList>.self, from: data)
                            completion(result)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    
                }
            }
    }
}
