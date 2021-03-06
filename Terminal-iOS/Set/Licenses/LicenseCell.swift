//
//  LicenseCell.swift
//  Terminal-iOS
//
//  Created by once on 2021/03/06.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class LicenseCell: UITableViewCell {
    static let cellID = "LicenseCellID"
    let library = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        attribute()
        layout()
    }
    
    func setData(library: String) {
        self.library.text = library
    }
    
    private func attribute() {
        self.library.do {
            $0.textColor = .white
            $0.dynamicFont(fontSize: 15, weight: .medium)
        }
    }
    
    private func layout() {
        self.contentView.addSubview(library)
        
        self.library.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
            $0.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
