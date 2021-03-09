//
//  BaseEmptyView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/17.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class BaseEmptyView: UIView {
    let iconImageView = UIImageView()
    let guideLabel = UILabel()
    var imageViewTopLayout: NSLayoutConstraint?
    var guideLabelTopLayout: NSLayoutConstraint?
    
    init() {
        super.init(frame: CGRect.zero)
        attribute()
        layout()
    }
    
    func attribute() {
        self.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        iconImageView.do {
            $0.image = UIImage(systemName: "books.vertical")?.withConfiguration(UIImage.SymbolConfiguration(weight: .light))
            $0.tintColor = .systemGray3
            $0.contentMode = .scaleAspectFill
        }
        guideLabel.do {
            $0.dynamicFont(fontSize: 20, weight: .bold)
            $0.textColor = .systemGray3
        }
    }
    
    func layout() {
        [iconImageView, guideLabel].forEach { addSubview($0) }
        
        imageViewTopLayout = iconImageView.topAnchor.constraint(equalTo: self.topAnchor,
                                                                constant: Terminal.convertHeight(value: 100))
        iconImageView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            imageViewTopLayout?.isActive = true
            $0.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.33).isActive = true
        }
        guideLabelTopLayout = guideLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor,
                                                              constant: Terminal.convertHeight(value: 50))
        guideLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            guideLabelTopLayout?.isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
