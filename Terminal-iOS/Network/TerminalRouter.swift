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
    
    // MARK: router case init
    
    // 유저 - 회원가입 로그인 비밀번호 찾기 일단 안넣음
    case nicknameCheck(nickname: String)
    case eamilCheck(email: String)
    case userInfo(id: String)
    case userInfoUpdate(id: String)
    case userWithdrawal(id: String, email: String, password: String)
    case emailVerify(id: String)
    case reissuanceToken(refreshToken: String)
    
    // 프로젝트
    case projectRegister(id: String, project: Project)
    case projectList(id: String)
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
    
    // MARK: URL endPoint init
    
    var endPoint: String {
        switch self {
        
        // 유저
        case let .nicknameCheck(nickname):
            return "user/check-nickname/\(nickname)"
        case let .eamilCheck(email):
            return "user/check-email/\(email)"
        case let .userInfo(id), let .userInfoUpdate(id):
            return "user/\(id)"
        case let .userWithdrawal(id, _, _):
            return "user/\(id)"
        case let .emailVerify(id):
            return "user/\(id)/emailVerify"
        case .reissuanceToken:
            return "user/reissuance"
            
        // 프로젝트
        case let .projectRegister(id, _), let .projectList(id):
            return "user/\(id)/project"
        case let .projectUpdate(id, projectID), let .projectDelete(id, projectID):
            return "user/\(id)/project/\(projectID)"
        
        // 스터디
        case .studyCreate, .studyList:
            return "study"
        case let .studyDetail(studyID), let .studyUpdate(studyID), let .studyDelete(studyID):
            return "study/\(studyID)"
        case .studyListForKey:
            return "study"
        case let .myStudyList(id):
            return "user/\(id)/study"
        
        // 신청
        case let .studyApply(studyID):
            return "study/\(studyID)/apply"
        
        // 공지사항
        case let .createNotice(studyID, _):
            return "study/\(studyID)/notice"
        case let .noticeDetail(studyID, noticeID):
            return "study/\(studyID)/notice/\(noticeID)"
        case let .noticeList(studyID):
            return "study/\(studyID)/notice"
        case let .noticeListForKey(studyID, _):
            return "study/\(studyID)/notice/paging/list"
        case let .noticeUpdate(studyID, noticeID):
            return "study/\(studyID)/notice/\(noticeID)"
        case let .noticeDelete(studyID, noticeID):
            return "study/\(studyID)/notice/\(noticeID)"
        }
    }
    
    var parameters: [String: String]? {
        switch self {
        
        /// 유저
      
        case .reissuanceToken(let refreshToken):
            return ["refresh_token": refreshToken]
        
        //스터디
       
        case .studyDetail:
            return nil
            
            
       
        case .nicknameCheck(nickname: let nickname):
            <#code#>
        case .eamilCheck(email: let email):
            <#code#>
        case .userInfo(id: let id):
            <#code#>
        case .userInfoUpdate(id: let id):
            <#code#>
        case .userWithdrawal(id: let id, email: let email, password: let password):
            <#code#>
        case .emailVerify(id: let id):
            <#code#>
        case .projectRegister(id: let id, project: let project):
            <#code#>
        case .projectList(id: let id):
            <#code#>
        case .projectUpdate(id: let id, projectID: let projectID):
            <#code#>
        case .projectDelete(id: let id, projectID: let projectID):
            <#code#>
        case .studyCreate(path: let path):
            <#code#>
        case .studyUpdate(studyID: let studyID):
            <#code#>
        case .studyDelete(studyID: let studyID):
            <#code#>
        case .studyList(category: let category, sort: let sort):
            <#code#>
        case .studyListForKey(value: let value):
            <#code#>
        case .myStudyList(id: let id):
            <#code#>
        case .studyApply(studyID: let studyID):
            <#code#>
        case .createNotice(studyID: let studyID, notice: let notice):
            <#code#>
        case .noticeDetail(studyID: let studyID, noticeID: let noticeID):
            <#code#>
        case .noticeList(studyID: let studyID):
            <#code#>
        case .noticeListForKey(studyID: let studyID, value: let value):
            <#code#>
        case .noticeUpdate(studyID: let studyID, noticeID: let noticeID):
            <#code#>
        case .noticeDelete(studyID: let studyID, noticeID: let noticeID):
            <#code#>
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
