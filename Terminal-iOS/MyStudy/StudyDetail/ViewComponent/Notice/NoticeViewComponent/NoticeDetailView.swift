//
//  NoticeDetailView.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/09.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class NoticeDetailView: UIViewController, NoticeDetailViewProtocol {
    
    var presenter: NoticeDetailPresenterProtocol?
    var parentView: UIViewController?
    var notice: Notice?
    var noticeID: Int?
    var state: StudyDetailViewState?
    var modifyButton = UIButton()
    var removeButton = UIButton()
    lazy var noticeBackground = UIView()
    lazy var noticeLabel = UILabel()
    lazy var noticeTitle = UILabel()
    lazy var profileImage = UIImageView()
    lazy var profileName = UILabel()
    lazy var noticeDate = UILabel()
    lazy var noticeContents = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad(notice: notice!)
        layout()
    }
    
    func attribute() {
        
        self.do {
            $0.view.backgroundColor = UIColor.appColor(.testColor)
        }
        noticeBackground.do {
            $0.layer.cornerRadius = 5
            $0.backgroundColor = notice!.pinned! ? UIColor.appColor(.pinnedNoticeColor) : UIColor.appColor(.noticeColor)
        }
        removeButton.do {
            $0.setTitle("삭제", for: .normal)
            $0.setTitleColor(.red, for: .normal)
            $0.addTarget(self, action: #selector(removeButtonDidTap), for: .touchUpInside)
            $0.isHidden = state == .host ? false : true
        }
        modifyButton.do {
            $0.setTitle("수정", for: .normal)
            $0.tintColor = UIColor.appColor(.mainColor)
            $0.setTitleColor(UIColor.appColor(.mainColor), for: .normal)
            $0.addTarget(self, action: #selector(modifyButtonDidTap), for: .touchUpInside)
            $0.isHidden = state == .host ? false : true
        }
        noticeLabel.do {
            $0.dynamicFont(fontSize: 12, weight: .medium)
            $0.textAlignment = .center
            $0.textColor = .white
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 5
            $0.text = notice!.pinned! ? "필독" : "공지"
        }
        noticeTitle.do {
            $0.dynamicFont(fontSize: 14, weight: .semibold)
            $0.textColor = .white
            $0.text = notice?.title
        }
        profileImage.do {
            $0.image = #imageLiteral(resourceName: "leehi")
            $0.contentMode = .scaleAspectFill
            $0.frame.size.width = Terminal.convertWidth(value: 35)
            $0.frame.size.height = Terminal.convertWidth(value: 35)
            $0.layer.cornerRadius = $0.frame.width / 2
            $0.clipsToBounds = true
        }
        
        profileName.do {
            $0.dynamicFont(fontSize: 12, weight: .medium)
            // 옵셔널로 들어와서 일단 넣어놈
            guard let name = notice?.leaderNickname else { return }
            $0.text = name
            $0.textColor = .white
            $0.textAlignment = .center
        }
        noticeDate.do {
            $0.dynamicFont(fontSize: 12, weight: .medium)
            $0.text = notice?.updatedAt
            $0.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            $0.textAlignment = .center
        }
        noticeContents.do {
            $0.dynamicFont(fontSize: 12, weight: .regular)
            $0.numberOfLines = 0
            $0.text = notice?.contents
        }
        
    }
    
    func layout() {
        [removeButton, modifyButton,noticeBackground, noticeTitle, profileImage, profileName, noticeDate, noticeContents].forEach { view.addSubview($0)}
        noticeBackground.addSubview(noticeLabel)
        
        noticeBackground.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Terminal.convertHeigt(value: 9)).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Terminal.convertHeigt(value: 13)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 41)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 20)).isActive = true
        }
        noticeLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: noticeBackground.centerXAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: noticeBackground.centerYAnchor).isActive = true
        }
        removeButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: noticeLabel.centerYAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: modifyButton.leadingAnchor, constant: -10).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 90)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 20)).isActive = true
        }
        modifyButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: noticeLabel.centerYAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Terminal.convertWidth(value: -10)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 90)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 20)).isActive = true
        }
        noticeTitle.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: self.noticeBackground.trailingAnchor, constant: Terminal.convertWidth(value: 15)).isActive = true
            $0.trailingAnchor.constraint(lessThanOrEqualTo: modifyButton.leadingAnchor, constant: -5).isActive = true
            $0.centerYAnchor.constraint(equalTo: noticeBackground.centerYAnchor).isActive = true
        }
        profileImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: noticeBackground.bottomAnchor, constant: Terminal.convertHeigt(value: 25)).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Terminal.convertHeigt(value: 13)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 35)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 35)).isActive = true
        }
        profileName.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: noticeBackground.bottomAnchor, constant: Terminal.convertHeigt(value: 25)).isActive = true
            $0.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: Terminal.convertWidth(value: 8)).isActive = true
        }
        noticeDate.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: profileName.bottomAnchor, constant: 2).isActive = true
            $0.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: Terminal.convertWidth(value: 8)).isActive = true
        }
        noticeContents.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: Terminal.convertHeigt(value: 25)).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Terminal.convertWidth(value: 13)).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Terminal.convertWidth(value: -13)).isActive = true
            $0.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor).isActive = true
        }
    }
    
    @objc func modifyButtonDidTap() {
        presenter?.modifyButtonDidTap(state: .edit, notice: notice!, parentView: self)
    }
    
    @objc func removeButtonDidTap() {
        presenter?.removeButtonDidTap(notice: notice!)
    }
    func showNoticeDetail(notice: Notice) {
        self.notice = notice
        attribute()
    }
    
    func showNoticeRemove(message: String) {
        self.dismiss(animated: true) { [self] in
            (self.parentView as! NoticeViewProtocol).viewLoad()
        }
    }
    
    func showError(message: String) {
        print("noticedetailview에서 생긴 에러")
    }
    
}
