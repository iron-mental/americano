//
//  ValidateSequence.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/13.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

struct ValidateSequence: Sequence, IteratorProtocol {
    var startValue: Int
    var endValue: Int

    mutating func next() -> Int? {
        if startValue > endValue { return nil }
        startValue += 1
        if startValue == 400 { return startValue + 2 }
        return startValue + 1
    }
    init(startValue: Int, endValue: Int) {
        self.startValue = startValue - 2
        self.endValue = endValue - 2
    }
}
