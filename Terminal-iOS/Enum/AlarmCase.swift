//
//  AlarmCase.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/15.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

enum AlarmType: String {
    case chat = "chat"
    case studyUpdate = "study_update"
    case studyHostDelegate = "study_delegate"
    case studyDelete = "study_delete"
    case newApply = "apply_new"
    case applyAllowed = "apply_allow"
    case applyRejected = "apply_reject"
    case newNotice = "notice_new"
    case updatedNotice = "notice_update"
    case testPush = "push_test"
    case undefined
}
