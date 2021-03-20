//
//  ProjectModifyInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/01.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

final class ProjectModifyInteractor: ProjectModifyInteractorInputProtocol {
    weak var presenter: ProjectModifyInteractorOutputProtocol?
    
    func completeModify(project: [Project]) {
        var projectArr: [[String: Any?]] = []
        
        for data in project {
            let param: [String: Any?] = [
                "id": data.id ?? nil,
                "title": data.title,
                "contents": data.contents,
                "sns_github": data.snsGithub ?? nil,
                "sns_appstore": data.snsAppstore ?? nil,
                "sns_playstore": data.snsPlaystore ?? nil
            ]
            projectArr.append(param)
        }
        
        let params: [String: Any] = [
            "project_list": projectArr
        ]
        
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.projectUpdate(id: userID, project: params))
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<Bool>.self, from: data)
                        let isSuccess = result.result
                        let message = result.message!
                        self.presenter?.didCompleteModify(result: isSuccess, message: message)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let err):
                    if let err = err.asAFError {
                        switch err {
                        case .sessionTaskFailed:
                            self.presenter?.sessionTaskError(message: TerminalNetworkManager.shared.sessionTaskErrorMessage)
                        default:
                            if let data = response.data {
                                do {
                                    let result = try JSONDecoder().decode(BaseResponse<Bool>.self, from: data)
                                    let message = result.message ?? ""
                                    let label = result.label ?? ""
                                    self.presenter?.modifyFailed(message: message, label: label)
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                        }
                    }
                }
            }
    }
}
