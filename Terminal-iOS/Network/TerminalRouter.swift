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
    typealias Parameters = [String: Any]
    
    // MARK: router case init
    
    case authCheck              (id: String)
    
    // 유저 - 회원가입 로그인 비밀번호 찾기 일단 안넣음
    case nicknameCheck          (nickname: String)
    case eamilCheck             (email: String)
    case userInfo               (id: String)
    
    case userImageUpdate        (id: String)
    case userInfoUpdate         (id: String, profile: Parameters)
    case userSNSUpdate          (id: String, sns: Parameters)
    case userCareerUpdate       (id: String, career: Parameters)
    case userLocationUpdate     (id: String, location: Parameters)
    
    case userWithdrawal         (id: String, userData: Parameters)
    case emailVerify            (id: String)
    case emailAuth              (id: String, email: String)
    case reissuanceToken        (refreshToken: String)
    case login                  (userData: Parameters)
    case logout                 (userID: String)
    case signUp                 (userData: Parameters)
    
    case address
    case alert                  (id: String)
    case alertConfirm           (userID: Int, alertID: Int)
    
    // 프로젝트
    case projectList            (id: String)
    case projectUpdate          (id: String, project: Parameters)

    // 스터디
    case studyCreate            (study: Parameters)
    case studyDetail            (studyID: String)
    case studyUpdate            (studyID: String, study: Parameters)
    case studyDelete            (studyID: String)
    case studyList              (sort: Parameters)
    case studyListForKey        (key: Parameters)
    case myStudyList            (id: String)
    case studySearch            (keyword: String)
    case hotKeyword
    case studyLeave             (studyID: String)
    case studyCategory
    case delegateHost           (studyID: Int, newLeader: Int)
    case reportStudy            (studyID: Int, message: String)
    case studyChat              (studyID: Int, date: Int, first: Bool)
    
    // 신청부분
    case applyStudy             (studyID: String, message: Parameters)
    case applyStudyList         (id: String)
    case applyUserList          (studyID: Int)
    case applyStudyDetail       (studyID: Int, userID: Int)
    case applyUserDetail        (studyID: Int, applyID: Int)
    case applyModify            (studyID: Int, applyID: Int, message: String)
    case applyDelete            (studyID: Int, applyID: Int)
    case applyDetermine         (studyID: Int, applyID: Int, status: Bool)
    
    // 공지사항
    case noticeCreate           (studyID: String, notice: Parameters)
    case noticeDetail           (studyID: String, noticeID: String)
    case noticeList             (studyID: String)
    case noticeListForKey       (studyID: String, value: String)
    case noticeUpdate           (studyID: String, noticeID: String, notice: Parameters)
    case noticeDelete           (studyID: String, noticeID: String)
    
    // COMMON
    case versionCheck           (version: String)
    
    var baseURL: URL {
        if endPoint == "check-version" {
            return URL(string: API.COMMON_BASE_URL)!
        } else {
            return URL(string: API.BASE_URL)!
        }
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
        case .userImageUpdate:
            return .put
        case .userInfoUpdate:
            return .put
        case .userSNSUpdate:
            return .put
        case .userCareerUpdate:
            return .put
        case .userLocationUpdate:
            return .put
            
        case .userWithdrawal:
            return .delete
        case .emailVerify:
            return .get
        case .emailAuth:
            return .put
        case .reissuanceToken:
            return .post
        case .login, .logout, .signUp:
            return .post
            
        case .address:
            return .get
        case .alert:
            return .get
        case .alertConfirm:
            return .get
            
            
        // 프로젝트
        case .projectList:
            return .get
        case .projectUpdate:
            return .post
            
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
        case .studySearch:
            return .get
        case .myStudyList:
            return .get
        case .hotKeyword:
            return .get
        case .studyLeave:
            return .post
        case .studyCategory:
            return .get
        case .delegateHost:
            return .put
        case .reportStudy:
            return .post
        case .studyChat:
            return .get
            
        // 신청
        case .applyStudy:
            return .post
        case .applyStudyList:
            return .get
        case .applyUserList:
            return .get
        case .applyStudyDetail:
            return .get
        case .applyUserDetail:
            return .get
        case .applyModify:
            return .put
        case .applyDelete:
            return .delete
        case .applyDetermine:
            return .post
            
        // 공지사항
        case .noticeCreate:
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
            
        // Common
        case .versionCheck:
            return .get
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
        case let .userInfo(id):
            return "user/\(id)"
            
        case let .userImageUpdate(id):
            return "user/\(id)/image"
        case let .userInfoUpdate(id, _):
            return "user/\(id)/info"
        case let .userSNSUpdate(id, _):
            return "user/\(id)/sns"
        case let .userCareerUpdate(id, _):
            return "user/\(id)/career"
        case let .userLocationUpdate(id, _):
            return "user/\(id)/location"
            
        case let .userWithdrawal(id, _):
            return "user/\(id)"
        case let .emailVerify(id):
            return "user/\(id)/emailVerify"
        case let .emailAuth(id, _):
            return "user/\(id)/email"
        case .reissuanceToken:
            return "user/reissuance"
        case .login:
            return "user/login"
        case .logout:
            return "user/logout"
        case .signUp:
            return "user"
            
        case .address:
            return "user/address"
        case let .alert(id):
            return "user/\(id)/alert"
        case let .alertConfirm(userID, alertID):
            return "user/\(userID)/alert/\(alertID)"
            
        // 프로젝트
        case let .projectList(id):
            return "user/\(id)/project"
        case let .projectUpdate(id, _):
            return "user/\(id)/project"
            
        // 스터디
        case .studyCreate, .studyList:
            return "study"
        case let .studyDetail(studyID), let .studyUpdate(studyID, _), let .studyDelete(studyID):
            return "study/\(studyID)"
        case .studyListForKey:
            return "study/paging/list"
        case let .myStudyList(id):
            return "user/\(id)/study"
        case .studySearch:
            return "study/search"
        case .hotKeyword:
            return "study/ranking"
        case let .studyLeave(studyID):
            return "study/\(studyID)/leave"
        case .studyCategory:
            return "study/category"
        case let .delegateHost(studyID, _):
            return "study/\(studyID)/delegate"
        case let .reportStudy(studyID, _):
            return "study/\(studyID)/report"
        case let .studyChat(studyID, _, _):
            return "study/\(studyID)/chat"
            
        // 신청
        case let .applyStudy(studyID, _):
            return "study/\(studyID)/apply"
        case let .applyStudyList(id):
            return "user/\(id)/apply"
        case let .applyUserList(studyID):
            return "study/\(studyID)/apply"
        case let .applyStudyDetail(studyID, userID):
            return "study/\(studyID)/applyUser/\(userID)"
        case let .applyUserDetail(studyID, applyID):
            return "study/\(studyID)/apply/\(applyID)"
        case let .applyModify(studyID, applyID, _):
            return "study/\(studyID)/apply/\(applyID)"
        case let .applyDelete(studyID, applyID):
            return "study/\(studyID)/apply/\(applyID)"
        case let .applyDetermine(studyID, applyID, _):
            return "study/\(studyID)/apply/\(applyID)"
            
        // 공지사항
        case let .noticeCreate(studyID, _):
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
            
        // Common
        case .versionCheck:
            return "check-version"
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
        case let .emailAuth(_, email):
            return ["email": email]
        case let .userCareerUpdate(_, career):
            return career
        case let .userInfoUpdate(_, profile):
            return profile
        case let .userSNSUpdate(_, sns):
            return sns
        case let .userLocationUpdate(_, location):
            return location
        case .userImageUpdate:
            return nil
            
        case let .userWithdrawal(_, userData):
            return userData
        case .reissuanceToken(let refreshToken):
            return ["refresh_token": refreshToken]
        case let .login(userData):
            return userData
        case let .logout(userID):
            return ["id": userID]
        case let .signUp(userData):
            return userData
            
        case .address, .alert, .alertConfirm:
            return nil
            
        // 스터디
        case .studyDetail:
            return nil
        case .studyDelete, .studyLeave, .studyCategory:
            return nil
        case .hotKeyword, .myStudyList:
            return nil
        case let .studyListForKey(value):
            return value
        case let .studyList(sort):
            return sort
        case let .studyCreate(study):
            return study
        case let .studySearch(keyword):
            return ["word": keyword]
        case let .studyUpdate(_, study):
            return study
        case let .delegateHost(_, newLeader):
            return ["new_leader": newLeader]
        case let .reportStudy(_, message):
            return ["message": message]
        case let .studyChat(_, date, first):
            return ["date": date,
                    "first": "\(first)"]
            
        // 신청
        case let .applyStudy(_, message):
            return message
        case .applyStudyList, .applyUserList:
            return nil
        case .applyStudyDetail, .applyUserDetail:
            return nil
        case let .applyModify(_, _, message):
            return ["message": message]
        case .applyDelete:
            return nil
        case let .applyDetermine(_, _, status):
            return ["allow": status]
            
        // 프로젝트
        case .projectList:
            return nil
        case let .projectUpdate(_, project):
            return project
            
        // 공지사항
        case let .noticeCreate(_, notice), let .noticeUpdate(_, _, notice):
            return notice
        case let .noticeListForKey(_, value):
            return ["values": value]
        case .noticeDetail, .noticeList, .noticeDelete:
            return nil
            
        // Common
        case let .versionCheck(version):
            return ["version": version, "device": "ios"]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        
        var request = URLRequest(url: url)
        request.method = method
    
        switch method {
        case .get:
            request = try URLEncoding.default.encode(request, with: parameters)
        case .post, .put, .delete:
            request = try JSONEncoding.default.encode(request, with: parameters)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
        default:
            break
        }
        
        return request
    }
}
