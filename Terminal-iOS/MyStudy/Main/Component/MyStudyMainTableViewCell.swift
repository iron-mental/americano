//
//  MyStudyMainTableViewCell.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/12.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class MyStudyMainTableViewCell: UITableViewCell {
    static let identifier = "MyStudyMainTableViewCell"
    
    var parentFrame = UIScreen.main.bounds
    var studyMainimage = UIImageView()
    var locationLabel = PaddingLabel(insets: UIEdgeInsets(top: 1, left: 2, bottom: 1, right: 2))
    var titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    func attribute() {
        self.do {
            $0.backgroundColor = UIColor.appColor(.testColor)
        }
        studyMainimage.do {
            $0.image = #imageLiteral(resourceName: "swiftmain")
            $0.contentMode = .scaleAspectFill
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 8
            $0.alpha = 0.8
        }
        locationLabel.do {
            $0.textColor = UIColor.appColor(.mainColor)
            $0.font = UIFont.notosansMedium(size: Terminal.convertWidth(value: 10))
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.appColor(.mainColor).cgColor
            $0.layer.cornerRadius = 8
            $0.layer.masksToBounds = true
            $0.textAlignment = .center
        }
        titleLabel.do {
            $0.font = UIFont.notosansBold(size: Terminal.convertWidth(value: 17))
            $0.textColor = UIColor.appColor(.profileTextColor)
        }
    }
    
    func layout() {
        [studyMainimage, locationLabel, titleLabel ].forEach { addSubview($0) }
        
        studyMainimage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: (24/375) * parentFrame.width).isActive = true
            $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 60)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 60)).isActive = true
        }
        locationLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor, constant: (15/667) * parentFrame.height).isActive = true
            $0.leadingAnchor.constraint(equalTo: studyMainimage.trailingAnchor, constant: (23/375) * parentFrame.width).isActive = true
        }
        titleLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: studyMainimage.trailingAnchor, constant: (23/375) * parentFrame.width).isActive = true
        }
    }
    
    func setData(study: MyStudy) {
        self.locationLabel.text = study.sigungu
        self.titleLabel.text = study.title
        self.layoutIfNeeded()
        guard let image = study.image else { return }
        if image.isEmpty {
            self.studyMainimage.image = UIImage(named: "swiftmain")
        } else {
            self.studyMainimage.kf.setImage(with: URL(string: image), options: [.requestModifier(RequestToken.token())])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setNeedsLayout()
        layoutIfNeeded()
    }
}
