//
//  ProfileModifyRemoteManager.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ProfileModifyRemoteManager: ProfileModifyRemoteDataManagerInputProtocol {
    var remoteRequestHandler: ProfileModifyRemoteDataManagerOutputProtocol?
    
    func validProfileModify(userInfo: UserInfoPut) {
        let url = "http://3.35.154.27:3000/v1/user/23"
        let params: Parameters = [
            "nickname": userInfo.nickname!,
            "introduce": userInfo.introduce!,
            "career_title": userInfo.careerTitle!,
            "career_contents": userInfo.careerContents!,
            "sns_github": userInfo.snsGithub!,
            "sns_linkedin": userInfo.snsLinkedin!,
            "latitude": userInfo.latitude!,
            "longitude": userInfo.longitude!,
            "sido": userInfo.sido!,
            "sigungu": userInfo.sigungu!
        ]
        
        AF.request(url,
                   method: .put,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: TerminalNetwork.headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                print(JSON(value))
            case .failure(let error):
                print(error)
            }
        }
    }
}
