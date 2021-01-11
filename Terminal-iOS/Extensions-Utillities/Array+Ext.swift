//
//  Array+Ext.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/09.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    func removeDuplication() -> [Element] {
        var addedDict = [Element: Bool]()
        return filter { addedDict.updateValue(true, forKey: $0) == nil }
    }
}
