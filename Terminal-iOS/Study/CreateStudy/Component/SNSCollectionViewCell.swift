//
//  SNSCollectionViewCell.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/16.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SNSCollectionViewCell: UICollectionViewCell {
    static  let identifier = "SNSCollectionViewCell"
    
    var icon = UIImageView()
    var verifiedImage = UIImageView()
    var textField = UITextField()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    func attribute() {
        self.backgroundColor = .green
        
        icon.do {
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.contentMode = .scaleAspectFill
            $0.image = #imageLiteral(resourceName: "notion")
        }
        textField.do {
            $0.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        }
        verifiedImage.do {
            $0.image = #imageLiteral(resourceName: "set_clicked")
        }
    }
    
    func layout() {
        addSubview(icon)
        addSubview(verifiedImage)
        addSubview(textField)
        
        icon.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        }
        verifiedImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        }
        textField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
