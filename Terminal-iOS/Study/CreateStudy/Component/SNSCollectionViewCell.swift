//
//  SNSCollectionViewCell.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/16.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SNSCollectionViewCell: UICollectionViewCell {
    static  let identifier = "cell"
    
    let verifiedImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
        
    }
    
    func attribute() {
        verifiedImage.do {
            $0.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            $0.image = #imageLiteral(resourceName: "set_clicked")
        }
    }
    
    func layout() {
        addSubview(verifiedImage)
        
        verifiedImage.do {
            $0.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
