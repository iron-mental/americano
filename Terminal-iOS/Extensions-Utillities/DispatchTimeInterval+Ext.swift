//
//  DispatchTimeInterval+Ext.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/28.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

extension DispatchTimeInterval {
    func toDouble() -> Double? {
        var result: Double? = 0

        switch self {
        case .seconds(let value):
            result = Double(value)
        case .milliseconds(let value):
            result = Double(value)*0.001
        case .microseconds(let value):
            result = Double(value)*0.000001
        case .nanoseconds(let value):
            result = Double(value)*0.000000001

        case .never:
            result = nil
        }

        return result
    }
}
