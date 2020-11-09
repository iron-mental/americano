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
    var locationLabel = UILabel()
    var titleLabel = UILabel()
    let newChatLabel = UILabel()
    let newNoticeLabel = UILabel()
    let newMemberLabel = UILabel()
    var checkBox = UIView()
    
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
            $0.contentMode = .scaleAspectFit
        }
        locationLabel.do {
            $0.text = "사당역 스타벅스"
            $0.textColor = UIColor.appColor(.mainColor)
            $0.font = $0.font.withSize(14 * (parentFrame.height / 667))
        }
        titleLabel.do {
            $0.text = "Swift 정복하기"
            $0.font = $0.font.withSize(16 * (parentFrame.height / 667))
        }
        newChatLabel.do {
            $0.text = "새 채팅"
            $0.backgroundColor = UIColor.appColor(.mainColor)
            $0.font = newChatLabel.font.withSize(13)
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.textAlignment = .center
        }
        newNoticeLabel.do {
            $0.text = "새 공지"
            $0.backgroundColor = UIColor.appColor(.mainColor)
            $0.font = newNoticeLabel.font.withSize(13)
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.textAlignment = .center
        }
        newMemberLabel.do {
            $0.text = "새 멤버"
            $0.backgroundColor = UIColor.appColor(.mainColor)
            $0.font = newMemberLabel.font.withSize(13)
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.textAlignment = .center
        }
        checkBox.do {
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.appColor(.mainColor).cgColor
            $0.backgroundColor = UIColor.systemBackground
            $0.layer.cornerRadius = Terminal.convertWidth(value: 20) / 2
            $0.layer.masksToBounds = true
        }
    }
    
    func layout() {
        [studyMainimage, locationLabel, titleLabel, newChatLabel, newNoticeLabel, newMemberLabel, checkBox].forEach { addSubview($0) }
        
        studyMainimage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: (24/375) * parentFrame.width).isActive = true
            $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 53)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 53)).isActive = true
        }
        locationLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor, constant: (15/667) * parentFrame.height).isActive = true
            $0.leadingAnchor.constraint(equalTo: studyMainimage.trailingAnchor, constant: (23/375) * parentFrame.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (20/667) * parentFrame.height).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (200/375) * parentFrame.width).isActive = true
        }
        titleLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(15/667) * parentFrame.height).isActive = true
            $0.leadingAnchor.constraint(equalTo: studyMainimage.trailingAnchor, constant: (23/375) * parentFrame.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (20/667) * parentFrame.height).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (200/375) * parentFrame.width).isActive = true
        }
        newChatLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.bottomAnchor.constraint(equalTo: newNoticeLabel.topAnchor, constant: -(4/667) * parentFrame.height).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(14/375) * parentFrame.width).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (50/375) * parentFrame.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (19/667) * parentFrame.height).isActive = true
        }
        newNoticeLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(14/375) * parentFrame.width).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (50/375) * parentFrame.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (19/667) * parentFrame.height).isActive = true
        }
        newMemberLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: newNoticeLabel.bottomAnchor, constant: (4/667) * parentFrame.height).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(14/375) * parentFrame.width).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (50/375) * parentFrame.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (19/667) * parentFrame.height).isActive = true
        }
        checkBox.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Terminal.convertWidth(value: 28)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 20)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 20)).isActive = true
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
