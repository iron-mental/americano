//
//  AddNoticeView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/27.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

enum AddNoticeState {
    case edit
    case new
}

class AddNoticeView: UIViewController {
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    var presenter: AddNoticePresenterProtocol?
    var studyID: Int?
    var notice: Notice? {
        didSet {
            attribute()
        }
    }
    var state: AddNoticeState?
    var dismissButton = UIButton()
    var titleGuideLabel = UILabel()
    var titleTextField = UITextField()
    var contentGuideLabel = UILabel()
    var contentTextView = UITextView()
    var completeButton = UIButton()
    var parentView: UIViewController?
    var bottomAnchor: NSLayoutConstraint?
    var keyboardHeight: CGFloat = 0.0
    var isEssentialFlagSege = UISegmentedControl(items: ["필독", "일반"])
    
    override func viewDidLoad() {
        attribute()
        layout()
        titleTextField.becomeFirstResponder()
        hideLoading()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        keyboardHeight = keyboardRectangle.height
        bottomAnchor?.constant = -(keyboardHeight + 15)
        bottomAnchor?.isActive = true
        view.layoutIfNeeded()
    }
    
    func attribute() {
        self.do {
            $0.view.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        isEssentialFlagSege.do {
            $0.selectedSegmentIndex = 1
            $0.selectedSegmentTintColor = UIColor.appColor(.noticeColor)
            $0.addTarget(self, action: #selector(segeIsMoving), for: .valueChanged)
        }
        dismissButton.do {
            $0.setImage(#imageLiteral(resourceName: "close"), for: .normal)
            $0.addTarget(self, action: #selector(dismissButtonTap), for: .touchUpInside)
        }
        titleGuideLabel.do {
            $0.text = "제목"
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.textColor = .white
            $0.dynamicFont(fontSize: 15, weight: .bold)
            $0.textAlignment = .center
        }
        titleTextField.do {
            $0.placeholder = "제목을 입력하세요"
            $0.text = notice == nil ? nil : notice?.title
            $0.textColor = .white
            $0.backgroundColor = UIColor.appColor(.InputViewColor)
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.delegate = self
            $0.addLeftPadding(padding: 10)
            $0.layer.borderColor = UIColor.gray.cgColor
            $0.layer.borderWidth = 0.1
        }
        contentGuideLabel.do {
            $0.text = "내용"
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.textColor = .white
            $0.dynamicFont(fontSize: 15, weight: .bold)
            $0.textAlignment = .center
        }
        contentTextView.do {
            $0.backgroundColor = UIColor.appColor(.InputViewColor)
            $0.textColor = .white
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.text = notice == nil ? nil : notice?.contents
            $0.layer.borderColor = UIColor.gray.cgColor
            $0.layer.borderWidth = 0.1
        }
        completeButton.do {
            $0.backgroundColor = UIColor.appColor(.mainColor)
            $0.setTitle("완료", for: .normal)
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.addTarget(self, action: #selector(completeButtonDidTap), for: .touchUpInside)
        }
    }
    
    func layout() {
        [isEssentialFlagSege, dismissButton, titleGuideLabel, titleTextField, contentGuideLabel, contentTextView, completeButton].forEach { view.addSubview($0) }
        
        isEssentialFlagSege.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: dismissButton.centerYAnchor).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
        dismissButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Terminal.convertHeight(value: 10)).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Terminal.convertHeight(value: 10)).isActive = true
        }
        titleGuideLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: titleTextField.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Terminal.convertWidth(value: 10)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 40)).isActive = true
        }
        titleTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: isEssentialFlagSege.bottomAnchor, constant: Terminal.convertHeight(value: 20)).isActive = true
            $0.leadingAnchor.constraint(equalTo: titleGuideLabel.trailingAnchor, constant: Terminal.convertWidth(value: 10)).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Terminal.convertWidth(value: 10)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 30)).isActive = true
        }
        contentGuideLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: Terminal.convertHeight(value: 10)).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Terminal.convertWidth(value: 10)).isActive = true
            $0.trailingAnchor.constraint(equalTo: titleGuideLabel.trailingAnchor).isActive = true
        }
        contentTextView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: contentGuideLabel.bottomAnchor, constant: Terminal.convertHeight(value: 10)).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Terminal.convertWidth(value: 10)).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Terminal.convertWidth(value: 10)).isActive = true
            $0.bottomAnchor.constraint(equalTo: completeButton.topAnchor, constant: -Terminal.convertHeight(value: 20)).isActive = true
        }
        bottomAnchor = completeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        completeButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            bottomAnchor?.isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 335)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 45)).isActive = true
        }
    }
    
    @objc func segeIsMoving(sender: UISegmentedControl) {
        isEssentialFlagSege.selectedSegmentTintColor = sender.selectedSegmentIndex == 0 ? UIColor.appColor(.pinnedNoticeColor) : UIColor.appColor(.noticeColor)
    }
    
    @objc func dismissButtonTap() {
        dismiss(animated: true) {
        }
    }
    
    @objc func completeButtonDidTap() {
        let newNoticePost = NoticePost(title: titleTextField.text ?? "",
                                       contents: contentTextView.text ?? "",
                                       pinned: isEssentialFlagSege.selectedSegmentIndex == 0 ? true : false)
        presenter?.completeButtonDidTap(studyID: studyID!, notice: newNoticePost, state: state!, noticeID: notice?.id ?? nil)
    }
}

extension AddNoticeView: AddNoticeViewProtocol {
    
    func showNewNotice(noticeID: Int) {
        let noticeTitle = titleTextField.text ?? ""
        showToast(controller: self, message: "공지사항 작성이 완료 되었습니다.", seconds: 1) { [self] in
            dismiss(animated: true) {
                if state == .new {
                    notice = Notice(id: noticeID,
                                    title: nil,
                                    contents: nil,
                                    leaderID: nil,
                                    studyID: studyID,
                                    pinned: nil,
                                    updatedAt: nil,
                                    leaderImage: nil,
                                    leaderNickname: nil,
                                    createAt: nil)
                    if let studyDetailView = parentView as? MyStudyDetailViewProtocol {
                        if let noticeListView = studyDetailView.VCArr[0] as? NoticeViewProtocol {
                            noticeListView.viewLoad()
                        }
                        studyDetailView.presenter?.addNoticeFinished(notice: noticeID, studyID: studyID!, title: noticeTitle, parentView: parentView!)
                    }
                } else {
                    if let noticeDetailView = parentView as? NoticeDetailViewProtocol {
                        noticeDetailView.presenter?.viewDidLoad(notice: notice!)
                        if let studyDetailView = noticeDetailView.parentView as? MyStudyDetailViewProtocol {
                            if let noticeListView = studyDetailView.VCArr[0] as? NoticeViewProtocol {
                                noticeListView.viewLoad()
                            }
                        } else {
                            if let noticeListView = noticeDetailView.parentView as? NoticeViewProtocol {
                                noticeListView.viewLoad()
                            }
                        }
                    }
                }
            }
        }
    }
    func showError(message: String) {
        showToast(controller: self, message: message, seconds: 1)
    }
    func showLoading() {
        LoadingRainbowCat.show()
    }
    
    func hideLoading() {
        LoadingRainbowCat.hide()
    }
}


extension AddNoticeView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        contentTextView.becomeFirstResponder()
    }
}

extension AddNoticeView: UITextViewDelegate {
    
}
