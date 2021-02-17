//
//  EmptyViewCase.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/17.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

enum EmptyViewCase {
    case StudyListEmptyView
    case LocationListEmptyView
    
    var view: UIView {
        switch self {
        case .StudyListEmptyView:
            return SearchStudyListEmptyView()
        case .LocationListEmptyView:
            return SearchLocationListEmptyView()
        }
    }
}
