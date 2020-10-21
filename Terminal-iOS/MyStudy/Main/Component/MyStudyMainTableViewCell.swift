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
    let studyMainimage = UIImageView()
    let locationLabel = UILabel()
    let titleLabel = UILabel()
    let newChatLabel = UILabel()
    let newNoticeLabel = UILabel()
    let newMemberLabel = UILabel()
    
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
            $0.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * (53 / 375), height: UIScreen.main.bounds.height * (53 / 667))
//            $0.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            $0.contentMode = .scaleAspectFit
        }
        locationLabel.do {
            $0.text = "사당역 스타벅스"
            $0.textColor = UIColor.appColor(.mainColor)
        }
        titleLabel.do {
            $0.text = "Swift 정복하기"
        }
        newChatLabel.do {
            $0.text = "새 채팅"
            $0.backgroundColor = UIColor.appColor(.mainColor)
            $0.font = newChatLabel.font.withSize(13)
            $0.layer.cornerRadius = 5
            $0.textAlignment = .center
        }
        newNoticeLabel.do {
            $0.text = "새 공지"
            $0.backgroundColor = UIColor.appColor(.mainColor)
            $0.font = newNoticeLabel.font.withSize(13)
            $0.layer.cornerRadius = 5
            $0.textAlignment = .center
        }
        newMemberLabel.do {
            $0.text = "새 멤버"
            $0.backgroundColor = UIColor.appColor(.mainColor)
            $0.font = newMemberLabel.font.withSize(13)
            $0.layer.cornerRadius = 5
            $0.textAlignment = .center
        }
    }
    
    func layout() {
        addSubview(studyMainimage)
        addSubview(locationLabel)
        addSubview(titleLabel)
        addSubview(newChatLabel)
        addSubview(newNoticeLabel)
        addSubview(newMemberLabel)
        
        studyMainimage.do {
            //bounds 접근 가능한지ㅘ뽀자
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: (24/375) * parentFrame.width).isActive = true
            $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        }
        locationLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor, constant: (15/667) * parentFrame.height).isActive = true
            $0.leadingAnchor.constraint(equalTo: studyMainimage.trailingAnchor, constant: (23/375) * parentFrame.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (31/667) * parentFrame.height).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (200/375) * parentFrame.width).isActive = true
        }
        titleLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(15/667) * parentFrame.height).isActive = true
            $0.leadingAnchor.constraint(equalTo: studyMainimage.trailingAnchor, constant: (23/375) * parentFrame.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (31/667) * parentFrame.height).isActive = true
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
            print(parentFrame.height)
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
    }
}
