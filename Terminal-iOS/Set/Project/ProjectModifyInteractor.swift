//
//  ProjectModifyInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/01.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper
import SwiftyJSON

class ProjectModifyInteractor: ProjectModifyInteractorInputProtocol {
    var presenter: ProjectModifyInteractorOutputProtocol?
    
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
            .validate(statusCode: 200...422)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<Bool>.self, from: data!)
                        self.presenter?.didCompleteModify(result: result.result, message: result.message!)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
