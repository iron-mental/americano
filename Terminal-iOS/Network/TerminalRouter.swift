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
    case userPost(path: String)
    case userGet(path: String)
    case studyPost(path: String)
    case studyGet(path: String)
    
    var baseURL: URL {
        return URL(string: API.BASE_URL)!
    }
    
    var method: HTTPMethod {
        switch self {
        case .studyGet:
            return .get
        case .studyPost:
            return .post
        case .userGet:
            return .get
        case .userPost:
            return .post
        }
    }
    
    var endPoint: String {
        switch self {
        case .studyGet, .studyPost:
            return "study/"
        case let .userGet(path), let .userPost(path):
            return "user/\(path)"
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case let .studyGet(path), let .studyPost(path):
            return ["query": path]
        case .userPost(path: let path):
            return ["query": path]
        case .userGet(path: let path):
            return ["query": path]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = baseURL.appendingPathComponent(endPoint)
        print("url :", url)
        var request = URLRequest(url: url)
        request.method = method
        
        request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        
        return request
    }
}
