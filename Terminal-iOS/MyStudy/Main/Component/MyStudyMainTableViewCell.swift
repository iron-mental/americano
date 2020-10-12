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
        studyMainimage.do {
            $0.image = #imageLiteral(resourceName: "leehi")
            $0.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            $0.contentMode = .scaleAspectFit
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
            $0.font = newChatLabel.font.withSize(13)
        }
        newNoticeLabel.do {
            $0.text = "새 공지"
            $0.backgroundColor = .red
            $0.font = newNoticeLabel.font.withSize(13)
        }
        newMemberLabel.do {
            $0.text = "새 멤버"
            $0.backgroundColor = .yellow
            $0.font = newMemberLabel.font.withSize(13)
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
            $0.widthAnchor.constraint(equalToConstant: 40).isActive = true
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
            $0.topAnchor.constraint(equalTo: topAnchor, constant: (13/667) * parentFrame.height).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: (14/375) * parentFrame.width).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (50/375) * parentFrame.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (19/667) * parentFrame.height).isActive = true
        }
        newNoticeLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: newChatLabel.bottomAnchor, constant: (4/667) * parentFrame.height).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: (14/375) * parentFrame.width).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (50/375) * parentFrame.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (19/667) * parentFrame.height).isActive = true
        }
        newMemberLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: newNoticeLabel.bottomAnchor, constant: (4/667) * parentFrame.height).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: (14/375) * parentFrame.width).isActive = true
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
