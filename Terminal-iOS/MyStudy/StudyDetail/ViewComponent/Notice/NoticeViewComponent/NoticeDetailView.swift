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
    lazy var moreButton = UIBarButtonItem(image: #imageLiteral(resourceName: "more"), style: .done, target: self, action: #selector(moreButtonDidTap))
    lazy var noticeBackground = UIView()
    lazy var noticeLabel = UILabel()
    lazy var profileImage = UIImageView()
    lazy var profileName = UILabel()
    lazy var noticeDate = UILabel()
    lazy var noticeContents = PaddingLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad(notice: notice!)
        attribute()
        layout()
    }
    
    func attribute() {
        self.do {
            $0.view.backgroundColor = UIColor.appColor(.testColor)
            navigationItem.rightBarButtonItems = [moreButton]
        }
        
        noticeBackground.do {
            $0.layer.cornerRadius = 5
            if let isPinned = notice?.pinned {
                $0.backgroundColor = isPinned
                    ? UIColor.appColor(.pinnedNoticeColor)  // true
                    : UIColor.appColor(.noticeColor)        // false
            }
        }
        
        noticeLabel.do {
            $0.dynamicFont(fontSize: 12, weight: .medium)
            $0.textAlignment = .center
            $0.textColor = .white
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 5
            if let isPinned = notice?.pinned {
                $0.text = isPinned ? "필독" : "일반"
            }
        }
        profileImage.do {
            let imageURL = notice?.leaderImage ?? ""
            $0.kf.setImage(with: URL(string: imageURL),
                           placeholder: UIImage(named: "defaultProfile"),
                           options: [.requestModifier(RequestToken.token())])
            $0.contentMode = .scaleAspectFill
            $0.frame.size.width = Terminal.convertWidth(value: 35)
            $0.frame.size.height = Terminal.convertWidth(value: 35)
            $0.layer.cornerRadius = $0.frame.width / 2
            $0.clipsToBounds = true
        }
        
        profileName.do {
            $0.dynamicFont(fontSize: 12, weight: .medium)
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
        [ noticeBackground, profileImage, profileName, noticeDate, noticeContents].forEach { view.addSubview($0)}
        noticeBackground.addSubview(noticeLabel)
        
        noticeBackground.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Terminal.convertHeigt(value: 13)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 41)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 20)).isActive = true
        }
        noticeLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: noticeBackground.centerXAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: noticeBackground.centerYAnchor).isActive = true
        }
        noticeContents.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: noticeBackground.bottomAnchor, constant: Terminal.convertHeigt(value: 25)).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Terminal.convertWidth(value: 13)).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Terminal.convertWidth(value: -13)).isActive = true
            $0.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor).isActive = true
        }
        profileImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Terminal.convertHeigt(value: 9)).isActive = true
            $0.leadingAnchor.constraint(equalTo: noticeBackground.trailingAnchor, constant: Terminal.convertHeigt(value: 13)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 35)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 35)).isActive = true
        }
        profileName.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: profileImage.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: Terminal.convertWidth(value: 8)).isActive = true
        }
        noticeDate.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: profileName.bottomAnchor, constant: 2).isActive = true
            $0.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor,
                                        constant: Terminal.convertWidth(value: 8)).isActive = true
        }
    }
    
    @objc func moreButtonDidTap() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let edit = UIAlertAction(title: "수정하기", style: .default) { _ in self.modifyButtonDidTap() }
        let applyList = UIAlertAction(title: "삭제하기", style: .destructive) {_ in self.removeButtonDidTap() }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        [edit, applyList, cancel].forEach { alert.addAction($0) }
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func modifyButtonDidTap() {
        presenter?.modifyButtonDidTap(state: .edit, notice: notice!, parentView: self)
    }
    
    @objc func removeButtonDidTap() {
        presenter?.removeButtonDidTap(notice: notice!)
    }
    
    func showNoticeDetail(notice: Notice) {
        self.title = notice.title
        self.notice = notice
        attribute()
    }
    
    func showNoticeRemove(message: String) {
        
        showToast(controller: self, message: message, seconds: 1) {
            if let noticeListView = self.parentView as? NoticeViewProtocol {
                noticeListView.viewLoad()
                self.navigationController?.popViewController(animated: true)
            }
            
        }
    }
    
    func showError(message: String) {
        print("noticedetailview에서 생긴 에러")
    }
    
}
