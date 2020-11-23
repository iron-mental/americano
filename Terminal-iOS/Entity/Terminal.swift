//
//  Terminal.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class Terminal {
    
    //kakao
    //bce7f6969838f58c8c27fa25722c220b
    static let screenSize = UIScreen.main.bounds

    static func convertHeigt(value: CGFloat) -> CGFloat{
        return screenSize.height * (value / 667)
    }
    
    static func convertWidth(value: CGFloat) -> CGFloat {
        return screenSize.width * (value / 375)
    }
    
    static let token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OSwiZW1haWwiOiJya2RjamYwMTIyQGdtYWlsLmNvbSIsIm5pY2tuYW1lIjoi64uJ64S0IiwiaWF0IjoxNjA2MTMzNjcwLCJleHAiOjEwNjA2MTMzNjcwLCJpc3MiOiJ0ZXJtaW5hbC1zZXJ2ZXIiLCJzdWIiOiJ1c2VySW5mby1hY2Nlc3MifQ.FcXxEdpssEV0UXLhKtr4MFVNkU3nfqKU2DWrh8862s4"
}
