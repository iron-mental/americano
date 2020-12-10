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
    typealias Parameters = [String: String]
    // MARK: router case init

    case authCheck          (id: String)
    
    // 유저 - 회원가입 로그인 비밀번호 찾기 일단 안넣음
    case nicknameCheck      (nickname: String)
    case eamilCheck         (email: String)
    case userInfo           (id: String)
    case userInfoUpdate     (id: String, userData: Parameters)
    case userWithdrawal     (id: String, email: String, password: String)
    case emailVerify        (id: String)
    case reissuanceToken    (refreshToken: String)
    case login              (userData: Parameters)
    case signUp             (userData: Parameters)
    
    // 프로젝트
    case projectRegister    (id: String, project: Parameters)
    case projectList        (id: String)
    case projectUpdate      (id: String, projectID: String)
    case projectDelete      (id: String, projectID: String)
    
    // 스터디 - 탈퇴, 장위임, 검색, 키워드 추가해야함
    case studyCreate        (path: [String: String])
    case studyDetail        (studyID: String)
    case studyUpdate        (studyID: String)
    case studyDelete        (studyID: String)
    case studyList          (category: String, sort: String)
    case studyListForKey    (value: String)
    case myStudyList        (id: String)
    
    // 신청부분
    case studyApply         (studyID: String, message: Parameters)
    
    // 공지사항
    case createNotice       (studyID: String, notice: Parameters)
    case noticeDetail       (studyID: String, noticeID: String)
    case noticeList         (studyID: String)
    case noticeListForKey   (studyID: String, value: [Int])
    case noticeUpdate       (studyID: String, noticeID: String, notice: Parameters)
    case noticeDelete       (studyID: String, noticeID: String)
    
    var baseURL: URL {
        return URL(string: API.BASE_URL)!
    }
    
    // MARK: Method init
    
    var method: HTTPMethod {
        switch self {
        
        // 토큰 최신화용
        case .authCheck:
            return .get
            
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
        case .login, .signUp:
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
    
    // MARK: URL EndPoint init
    
    var endPoint: String {
        switch self {
        
        case let .authCheck(id):
            return "user/\(id)"
        
        // 유저
        case let .nicknameCheck(nickname):
            return "user/check-nickname/\(nickname)"
        case let .eamilCheck(email):
            return "user/check-email/\(email)"
        case let .userInfo(id), let .userInfoUpdate(id, _):
            return "user/\(id)"
        case let .userWithdrawal(id, _, _):
            return "user/\(id)"
        case let .emailVerify(id):
            return "user/\(id)/emailVerify"
        case .reissuanceToken:
            return "user/reissuance"
        case .login:
            return "user/login"
        case .signUp:
            return "user"
            
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
            return "study/paging/list"
        case let .myStudyList(id):
            return "user/\(id)/study"
            
        // 신청
        case let .studyApply(studyID, _):
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
        case let .noticeUpdate(studyID, noticeID, _):
            return "study/\(studyID)/notice/\(noticeID)"
        case let .noticeDelete(studyID, noticeID):
            return "study/\(studyID)/notice/\(noticeID)"

        // 어떻게 정리하면 좋을지 생각해봐야할듯 뭔가 다닥다닥 있는뎀
        }
    }
    
    // MARK: Parameter init
    
    var parameters: Parameters? {
        switch self {
        
        case .authCheck:
            return nil
        
        // 유저
        case .nicknameCheck, .eamilCheck, .userInfo, .emailVerify:
            return nil
        case let .userInfoUpdate(_, userData): // 수정해야함
            return userData
        case let .userWithdrawal(_, email, password):
            return [
                "email": email,
                "password": password
            ]
        case .reissuanceToken(let refreshToken):
            return ["refresh_token": refreshToken]
        case let .login(userData):
            return userData
        case let .signUp(userData):
            return userData
            
        // 스터디
        case .studyDetail, .studyDelete, .myStudyList:
            return nil
        case let .studyListForKey(value):
            return [
                "values" : value
            ]
        case let .studyList(category, sort):
            return [
                "category": category,
                "sort": sort
            ]
        case .studyCreate: // 파라미터 지정해야함
            return nil
        case .studyUpdate:// 파라미터 지정해야함
            return nil
            
        // 신청
        case let .studyApply(_, message):
            return message
        
        // 프로젝트
        case .projectList, .projectDelete:
            return nil
        case .projectRegister: // 수정해야함
            return nil
        case .projectUpdate: // 수정해야함
            return nil
            
        // 공지사항
        case let .createNotice(_, notice), let .noticeUpdate(_, _, notice):
            return notice
        case .noticeDetail, .noticeList, .noticeListForKey, .noticeDelete:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = baseURL.appendingPathComponent(endPoint)
        
        var request = URLRequest(url: url)
        request.method = method
        
        switch method {
        case .get:
            request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        case .post, .put, .delete:
            request = try JSONParameterEncoder().encode(parameters, into: request)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
        default:
            break
        }
        
        return request
    }
}
