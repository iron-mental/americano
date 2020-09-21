//
//  SNSInputUIView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/20.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SNSInputUIView: UIView {
    var titleLabel = UILabel()
    var notion = SNSInputItem(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
    var evernote = SNSInputItem(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
    var web = SNSInputItem(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        notion.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
            $0.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
