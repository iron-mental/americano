//
//  TerminalNetwork.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/12.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import SwiftyJSON

class TerminalNetwork {
    static let headers: HTTPHeaders = [
        "authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJya2RjamYwMTIyQG5hdmVyLmNvbSIsIm5pY2tuYW1lIjoi64uJ64S067OA6rK97ZWo7JqUIiwiaWF0IjoxNjA2NDA1NDAxLCJleHAiOjEwNjA2NDA1NDAxLCJpc3MiOiJ0ZXJtaW5hbC1zZXJ2ZXIiLCJzdWIiOiJ1c2VySW5mby1hY2Nlc3MifQ.FgCJIyemTA0YGkVA2qlRhPgjvm3CrDH0enqX_u9JPmc"
    ]
    
    static func authRequest(urlRequest: String) {
        let url = "http://3.35.154.27:3000/v1/user/reissuance"
        let parameters: [String: String] = [
            "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjA2NTczOTQ1LCJleHAiOjE2MDc4Njk5NDUsImlzcyI6InRlcm1pbmFsLXNlcnZlciIsInN1YiI6InVzZXJJbmZvLXJlZnJlc2gifQ.3Uk12I5vhy3uWM16WFcx88NF7b0bjm2-l5H3GbFzFJA"
        ]
        AF.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
            case .failure(let err):
                print(err)
            }
        }
    }
}
