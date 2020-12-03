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
        let headers: HTTPHeaders = [ "Content-Type": "multipart/form-data",
                                     "Authorization": Terminal.accessToken]
        let params: Parameters = [
            "image": userInfo.image!,
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
        
        let uploadImage = userInfo.image!.jpegData(compressionQuality: 0.5)
        
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in params {
                let data = "\(value)".data(using: .utf8)!
                multipartFormData.append(data, withName: key, mimeType: "text/plain")
            }
            multipartFormData.append(uploadImage!, withName: "image", fileName: "\(userInfo.nickname!).jpg", mimeType: "image/jpeg")
        }, to: url, method: .put, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                print(JSON(value))
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func remoteProjectList(completion: @escaping ([Project]) -> Void) {
        let url = "http://3.35.154.27:3000/v1/user/44/project"
        
        AF.request(url, headers: TerminalNetwork.headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let data = "\(json)".data(using: .utf8)
                do {
                    let result = try JSONDecoder().decode([Project].self, from: data!)
                    completion(result)
                } catch {
                    print("에러")
                }
            case .failure(let error):
                print("에러:", error)
            }
        }
    }
    
    func removeProject(projectID: Int, completion: @escaping (Bool) -> Void) {
        let url = "http://3.35.154.27:3000/v1/user/44/project/\(projectID)"
        
        AF.request(url, method: .delete, headers: TerminalNetwork.headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let data = "\(json)".data(using: .utf8)
                do {
                    let result = try JSONDecoder().decode(BaseResponse<Bool>.self, from: data!)
                    if result.result {
                        completion(true)
                    }
                } catch {
                    print("에러")
                }
            case .failure(let error):
                print("에러:", error)
            }
        }
    }
    
    func registerProject() {
        
    }
}
