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
        studyMainimage.do {
            $0.image = #imageLiteral(resourceName: "leehi")
        }
        locationLabel.do {
            $0.text = "이수역 부추삼겹살"
        }
        titleLabel.do {
            $0.text = "부추삼겹살 스터디!!"
        }
        newChatLabel.do {
            $0.text = "새 채팅"
            $0.backgroundColor = .blue
        }
        newNoticeLabel.do {
            $0.text = "새 공지"
            $0.backgroundColor = .red
        }
        newMemberLabel.do {
            $0.text = "새 멤버"
            $0.backgroundColor = .yellow
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
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: (24/375) * self.bounds.width).isActive = true
            $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        }
        locationLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor, constant: (15/667) * self.bounds.height).isActive = true
            $0.leadingAnchor.constraint(equalTo: studyMainimage.trailingAnchor, constant: (23/375) * self.bounds.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (31/375) * self.bounds.height).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (200/375) * self.bounds.width).isActive = true
        }
        titleLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: (15/667) * self.bounds.height).isActive = true
            $0.leadingAnchor.constraint(equalTo: studyMainimage.trailingAnchor, constant: (23/375) * self.bounds.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (31/375) * self.bounds.height).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (200/375) * self.bounds.width).isActive = true
        }
        newChatLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor, constant: (13/375) * self.bounds.height).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: (14/375) * 375).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (50/375) * self.bounds.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (19/375) * self.bounds.height).isActive = true
        }
        newNoticeLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: newChatLabel.bottomAnchor, constant: (4/375) * self.bounds.height).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: (14/375) * 375).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (50/375) * self.bounds.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (19/375) * self.bounds.height).isActive = true
        }
        newMemberLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: newNoticeLabel.bottomAnchor, constant: (4/375) * self.bounds.height).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: (14/375) * 375).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (50/375) * self.bounds.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (19/375) * self.bounds.height).isActive = true
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
