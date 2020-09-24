//
//  TimeUIView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/23.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class TimeUIView: UIView {
    var title = UILabel()
    var detailTime = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    func attribute() {
        title.do {
            $0.text = "장소"
        }
        detailTime.do {
            $0.placeholder = "상세 위치"
        }
    }
    
    func layout() {
        addSubview(title)
        addSubview(detailTime)
        
        title.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (32/352) * frame.size.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (14/53) * frame.size.height).isActive = true
        }
        detailTime.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: title.bottomAnchor, constant: (13/53) * frame.size.height).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (14/53) * frame.size.height).isActive = true
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

