//
//  NoticeDetailView.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/09.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class NoticeDetailView: UIViewController {
    var presenter: NoticeDetailPresenterProtocol?
    var parentView: UIViewController?
    var notice: Notice?
    var state: StudyDetailViewState?
    lazy var moreButton = UIBarButtonItem()
    let noticeBackground = UIView()
    let noticeLabel = UILabel()
    lazy var profileImage = UIImageView()
    let profileName = UILabel()
    let noticeDate = UILabel()
    let noticeContents = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        presenter?.viewDidLoad(notice: notice!)
    }
    
    func attribute() {
        self.do {
            $0.view.backgroundColor = .appColor(.terminalBackground)
            navigationItem.rightBarButtonItems = state == .host ? [moreButton] : nil
        }
        self.moreButton.do {
            $0.image = UIImage(systemName: "ellipsis")?.withConfiguration(UIImage.SymbolConfiguration(weight: .regular))
            $0.target = self
            $0.action = #selector(moreButtonDidTap)
        }
        noticeBackground.do {
            $0.layer.cornerRadius = 5
        }
        noticeLabel.do {
            $0.dynamicFont(fontSize: 12, weight: .medium)
            $0.textAlignment = .center
            $0.textColor = .white
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 5
        }
        profileImage.do {
            $0.contentMode = .scaleAspectFill
            $0.frame.size.width = Terminal.convertWidth(value: 35)
            $0.frame.size.height = Terminal.convertWidth(value: 35)
            $0.layer.cornerRadius = $0.frame.width / 2
            $0.clipsToBounds = true
        }
        profileName.do {
            $0.dynamicFont(fontSize: 12, weight: .medium)
            $0.textColor = .white
            $0.textAlignment = .center
        }
        noticeDate.do {
            $0.dynamicFont(fontSize: 12, weight: .medium)
            $0.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            $0.textAlignment = .center
        }
        noticeContents.do {
            $0.dynamicFont(size: 12, weight: .regular)
            $0.isEditable = false
            $0.bounces = false
            $0.backgroundColor = .appColor(.cellBackground)
            $0.layer.cornerRadius = 10
            $0.layer.borderColor = UIColor.gray.cgColor
            $0.layer.borderWidth = 0.1
        }
    }
    
    func layout() {
        [ noticeBackground, profileImage, profileName, noticeDate, noticeContents].forEach { view.addSubview($0) }
        noticeBackground.addSubview(noticeLabel)
        
        noticeBackground.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                        constant: Terminal.convertHeight(value: 13)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 41)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 20)).isActive = true
        }
        noticeLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: noticeBackground.centerXAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: noticeBackground.centerYAnchor).isActive = true
        }
        noticeContents.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: noticeBackground.bottomAnchor,
                                    constant: Terminal.convertHeight(value: 25)).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                        constant: Terminal.convertWidth(value: 13)).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                         constant: Terminal.convertWidth(value: -13)).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                       constant: Terminal.convertHeight(value: -10)).isActive = true
        }
        profileImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                    constant: Terminal.convertHeight(value: 9)).isActive = true
            $0.leadingAnchor.constraint(equalTo: noticeBackground.trailingAnchor,
                                        constant: Terminal.convertHeight(value: 13)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 35)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 35)).isActive = true
        }
        profileName.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: profileImage.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor,
                                        constant: Terminal.convertWidth(value: 8)).isActive = true
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
        let applyList = UIAlertAction(title: "삭제하기", style: .destructive) { _ in self.removeButtonDidTap() }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        [edit, applyList, cancel].forEach { alert.addAction($0) }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popoverController = alert.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func modifyButtonDidTap() {
        presenter?.modifyButtonDidTap(state: .edit, notice: notice!, parentView: self)
    }
    
    @objc func removeButtonDidTap() {
        presenter?.removeButtonDidTap(notice: notice!)
    }
}

extension NoticeDetailView: NoticeDetailViewProtocol {
    func showNoticeDetail(notice: Notice) {
        self.title = notice.title
        self.notice = notice
        
        if let pinned = notice.pinned {
            self.noticeBackground.backgroundColor =
                pinned
                ? .appColor(.pinnedNoticeColor)
                : .appColor(.noticeColor)
            
            self.noticeLabel.text =
                pinned
                ? "필독"
                : "일반"
        }
        
        let imageURL = notice.leaderImage ?? ""
        self.profileImage.kf.setImage(with: URL(string: imageURL),
                                      placeholder: UIImage(named: "defaultProfile"),
                                      options: [.requestModifier(RequestToken.token())])
        
        let name = notice.leaderNickname ?? ""
        self.profileName.text = name
        
        let timestamp = notice.updatedAt
        let date = "\(Date(timeIntervalSince1970: TimeInterval(timestamp)))"
        
        let endIdx: String.Index = date.index(date.startIndex, offsetBy: 19)
        let dateResult = String(date[...endIdx])
        self.noticeDate.text = dateResult
        
        let contents = notice.contents ?? ""
        self.noticeContents.text = contents
    }
    
    func showNoticeRemove(message: String) {
        showToast(controller: self, message: message, seconds: 1) {
            if let studyDetailView = self.parentView as? MyStudyDetailView {
                self.parentView = studyDetailView.vcArr[0]
            }
            if let noticeListView = self.parentView as? NoticeViewProtocol {
                noticeListView.viewLoad()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func showError(message: String) {
        showToast(controller: self, message: message, seconds: 1)
    }
    
    func showLoading() {
        LoadingRainbowCat.show(caller: self)
    }
    
    func hideLoading() {
        LoadingRainbowCat.hide(caller: self)
    }
}
