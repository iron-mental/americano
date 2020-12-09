//
//  TerminalRouter.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/03.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import Alamofire

enum TerminalRouter: URLRequestConvertible {
    
    // MARK: case init
    
    // 유저 - 회원가입 로그인 비밀번호 찾기 일단 안넣음
    case nicknameCheck(nickname: String)
    case eamilCheck(email: String)
    case userInfo(id: String)
    case userInfoUpdate(id: String)
    case userWithdrawal(id: String, email: String, password: String)
    case emailVerify(id: String)
    case reissuanceToken(refreshToken: String)
    
    // 프로젝트
    case projectRegister(path: String, project: Project)
    case projectList(path: String)
    case projectUpdate(id: String, projectID: String)
    case projectDelete(id: String, projectID: String)
    
    // 스터디 - 탈퇴, 장위임, 검색, 키워드 추가해야함
    case studyCreate(path: Parameters)
    case studyDetail(studyID: String)
    case studyUpdate(studyID: String)
    case studyDelete(studyID: String)
    case studyList(category: String, sort: String)
    case studyListForKey(value: [Int])
    case myStudyList(id: String)
    
    // 신청부분
    case studyApply(studyID: String)
    
    // 공지사항
    case createNotice(studyID: String, notice: Notice2)
    case noticeDetail(studyID: String, noticeID: String)
    case noticeList(studyID: String)
    case noticeListForKey(studyID: String, value: [Int])
    case noticeUpdate(studyID: String, noticeID: String)
    case noticeDelete(studyID: String, noticeID: String)
    
    var baseURL: URL {
        return URL(string: API.BASE_URL)!
    }
    
    // MARK: method init
    
    var method: HTTPMethod {
        switch self {
        
        // 유저
        case .nicknameCheck:
            return .get
        case .eamilCheck:
            return .get
        case .userInfo:
            return .get
        case .userInfoUpdate:
            return .put
        case .userWithdrawal:
            return .delete
        case .emailVerify:
            return .get
        case .reissuanceToken:
            return .post
     
        // 프로젝트
        case .projectRegister:
            return .post
        case .projectList:
            return .get
        case .projectUpdate:
            return .put
        case .projectDelete:
            return .delete
            
        // 스터디
        case .studyCreate:
            return .post
        case .studyDetail:
            return .get
        case .studyUpdate:
            return .put
        case .studyDelete:
            return .delete
        case .studyList:
            return .get
        case .studyListForKey:
            return .get
        case .myStudyList:
            return .get

        // 신청
        case .studyApply:
            return .post
            
            
        // 공지사항
        case .createNotice:
            return .post
        case .noticeDetail:
            return .get
        case .noticeList:
            return .get
        case .noticeListForKey:
            return .get
        case .noticeUpdate:
            return .put
        case .noticeDelete:
            return .delete
        }
    }
    
    var endPoint: String {
        switch self {
        case .studyGet, .studyPost:
            return "study/"
        case let .userGet(path), let .userPost(path):
            return "user/\(path)"
        case .studyListGet:
            return "study"
        case .reissuanceToken:
            return "user/reissuance"
        case let .studyDetail(path):
            return "study/\(path)"
            
            
        case .nicknameCheck(path: let path):
            return "study/\(path)"
        case .eamilCheck(path: let path):
            return "study/\(path)"
        case .userWithdrawal(path: let path, email: let email, password: let password):
            return "study/\(path)"
        case .emailVerify(path: let path):
            return "study/\(path)"
        case .projectRegister(path: let path, project: let project):
            return "study/\(path)"
        }
    }
    
    var parameters: [String: String]? {
        switch self {
        
        /// 유저
        case .userPost(path: let path):
            return ["query": path]
        case .userGet:
            return nil
        case .reissuanceToken(let refreshToken):
            return [
//                "access_token": accessToken,
                "refresh_token": refreshToken
            ]
        
        //스터디
        case let .studyGet(path), let .studyPost(path):
            return ["query": path]
        case .studyListGet(let category, let sort):
            return ["category": category, "sort": sort]
        case .studyDetail:
            return nil
            
            
        case .nicknameCheck(path: let path):
            return nil
        case .eamilCheck(path: let path):
            return nil
        case .userWithdrawal(path: let path, email: let email, password: let password):
            return nil
        case .emailVerify(path: let path):
            return nil
        case .projectRegister(path: let path, project: let project):
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = baseURL.appendingPathComponent(endPoint)

        var request = URLRequest(url: url)
        request.method = method
        
        if method == .get {
          request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        } else if method == .post {
          request = try JSONParameterEncoder().encode(parameters, into: request)
          request.setValue("application/json", forHTTPHeaderField: "Accept")
        }

        return request
    }
}
