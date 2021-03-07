//
//  TerminalNetworkManager.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/03.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import Alamofire

final class TerminalNetworkManager {
    static let shared = TerminalNetworkManager()

    /// 인터셉터
    let interceptors = Interceptor(interceptors: [BaseInterceptor()])

    /// 세션 설정
    var session: Session
    
    /// SessionTaskError 메세지
    var sessionTaskErrorMessage = "서버와의 연결이 불안정합니다."
    
    private init() {
        session = Session(interceptor: interceptors)
    }
}
