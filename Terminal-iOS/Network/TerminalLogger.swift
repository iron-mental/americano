//
//  TerminalLogger.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/10.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import Alamofire

final class TerminalLogger: EventMonitor {
    
    let queue: DispatchQueue = DispatchQueue(label: "TermialAPI")
    
    func requestDidResume(_ request: Request) {
        print("Terminal Logger - requestDidResume")
        debugPrint(request)
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        
    }
}
