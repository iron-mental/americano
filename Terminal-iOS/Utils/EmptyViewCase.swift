//
//  EmptyViewCase.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/17.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

enum EmptyViewCase {
    case SearchStudyListEmptyViewType
    case SearchLocationListEmptyViewType
    case NotiListEmptyViewType
    
    var view: UIView {
        switch self {
        case .SearchStudyListEmptyViewType:
            return SearchStudyListEmptyView()
        case .SearchLocationListEmptyViewType:
            return SearchLocationListEmptyView()
        case .NotiListEmptyViewType:
            return NotiListEmptyView()
        }
    }
}
