//
//  PinnedNoticeCell.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/08.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class PinnedNoticeCell: NoticeCell {
    override func attribute() {
        super.attribute()
        noticeBackground.backgroundColor = UIColor.appColor(.pinnedNoticeColor)
        noticeLabel.text = "필독"
    }
}
