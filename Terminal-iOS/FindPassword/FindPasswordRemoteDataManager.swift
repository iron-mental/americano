//
//  FindPasswordRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by once on 2021/02/26.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

final class FindPasswordRemoteDataManager: FindPasswordRemoteDataManagerInputProtocol {
    var interactor: FindPasswordRemoteDataManagerOutputProtocol?
    
    func resetPassword(email: String) {
        let url = API.BASE_URL+"user/reset-password/\(email)"
        
        AF.request(url,
                   method: .post)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<Bool>.self, from: data)
                        self.interactor?.resetResponse(result: result)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<Bool>.self, from: data)
                            self.interactor?.resetResponse(result: result)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
    }
}
