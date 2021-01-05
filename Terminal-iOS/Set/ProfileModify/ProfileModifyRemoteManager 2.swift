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
import SwiftKeychainWrapper

class ProfileModifyRemoteManager: ProfileModifyRemoteDataManagerInputProtocol {
    var remoteRequestHandler: ProfileModifyRemoteDataManagerOutputProtocol?
    
    func authCheck(completion: @escaping () -> Void) {
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.userInfo(id: userID))
            .validate(statusCode: 200..<299)
            .responseJSON { [weak self] response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    let result = try! JSONDecoder().decode(BaseResponse<UserInfo>.self, from: data!)
                    if result.result {
                        completion()
                    }
                case .failure(let err):
                    print("실패")
                    print(err)
                }
            }
    }
    
    func validProfileModify(userInfo: UserInfoPut) {
        let url = "http://3.35.154.27:3000/v1/user/44"
        let headers: HTTPHeaders = [ "Content-Type": "multipart/form-data",
                                     "Authorization": Terminal.accessToken]
        let params: Parameters = [
            "image": userInfo.image!,
            "nickname": userInfo.nickname!,
            "introduce": userInfo.introduce!,
            "career_title": userInfo.careerTitle!,
            "career_contents": userInfo.careerContents!,
            "sns_github": userInfo.snsGithub!,
            "sns_linkedin": userInfo.snsLinkedIn!,
            "sns_web": userInfo.snsWeb!,
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
                print("여기닷:",JSON(value))
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func remoteProjectList(completion: @escaping (BaseResponse<[Project]>) -> Void) {
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }

        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.projectList(id: userID))
            .validate(statusCode: 200..<299)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print("성공:",JSON(value))
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    let result = try! JSONDecoder().decode(BaseResponse<[Project]>.self, from: data!)
                    completion(result)
                case .failure(let error):
                    print("에러:", error)
                }
            }
    }
    
    func removeProject(projectID: Int, completion: @escaping (Bool) -> Void) {
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.projectDelete(id: userID, projectID: String(projectID)))
            .validate(statusCode: 200..<299)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<Bool>.self, from: data!)
                        if result.result {
                            completion(true)
                        } else {
                            completion(false)
                        }
                    } catch {
                        print("에러")
                        completion(false)
                    }
                case .failure(let error):
                    print("에러:", error)
                    completion(false)
                }
            }
    }
    
    func registerProject(project: [String: String]) {
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        print(project)
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.projectRegister(id: userID, project: project))
            .validate(statusCode: 200..<299)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print(JSON(value))
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<Bool>.self, from: data!)
                        if result.result {
                            print("성공",result)
                        } else {
                            print("실패",result)
                        }
                    } catch {
                        print("에러")
                    }
                case .failure(let error):
                    print("에러:", error)
                }
            }
    }
}