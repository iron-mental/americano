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

final class AddNoticeView: UIViewController {
    deinit { self.keyboardRemoveObserver() }
    
    var presenter: AddNoticePresenterProtocol?
    var studyID: Int?
    var notice: Notice? { didSet { attribute() } }
    var state: AddNoticeState?
    var dismissButton = UIButton()
    var titleGuideLabel = UILabel()
    var titleTextField = UITextField()
    var contentGuideLabel = UILabel()
    var contentTextView = UITextView()
    var textCountLabel = UILabel()
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
        self.keyboardAddObserver(showSelector: #selector(keyboardWillShow))
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
            if let pinned = self.notice?.pinned {
                $0.selectedSegmentIndex = pinned ? 0 : 1
                $0.selectedSegmentTintColor
                    = pinned
                    ? .appColor(.pinnedNoticeColor)
                    : .appColor(.noticeColor)
            } else {
                $0.selectedSegmentIndex = 1
                $0.selectedSegmentTintColor = .appColor(.noticeColor)
            }
            $0.addTarget(self, action: #selector(segeIsMoving), for: .valueChanged)
        }
        dismissButton.do {
            $0.setImage(UIImage(systemName: "xmark"), for: .normal)
            $0.tintColor = .white
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
            $0.dynamicFont(fontSize: 15, weight: .regular)
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
            $0.dynamicFont(size: 14, weight: .regular)
            $0.delegate = self
        }
        textCountLabel.do {
            $0.textColor = .gray
            $0.textAlignment = .right
            $0.dynamicFont(fontSize: 12, weight: .regular)
            $0.text = "0/200"
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
        [isEssentialFlagSege, dismissButton, titleGuideLabel, titleTextField, contentGuideLabel, textCountLabel, contentTextView, completeButton].forEach { view.addSubview($0) }
        
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
        textCountLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: contentGuideLabel.centerYAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor).isActive = true
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
        isEssentialFlagSege.selectedSegmentTintColor
            = sender.selectedSegmentIndex == 0
            ? UIColor.appColor(.pinnedNoticeColor)
            : UIColor.appColor(.noticeColor)
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
                notice = Notice(id: noticeID,
                                title: nil,
                                contents: nil,
                                leaderID: nil,
                                studyID: studyID,
                                pinned: nil,
                                updatedAt: 0,
                                leaderImage: nil,
                                leaderNickname: nil,
                                createAt: 0,
                                isPaging: nil)
                
                parentView?.navigationController?.viewControllers.forEach {
                    if let myStudyDetail = $0 as? MyStudyDetailViewProtocol {
                        myStudyDetail.viewState = .Notice
                        if let noticeListView = myStudyDetail.vcArr[0] as? NoticeViewProtocol {
                            noticeListView.viewLoad()
                        }
                        if state == .new {
                            myStudyDetail.presenter?.addNoticeFinished(notice: noticeID,
                                                                       studyID: studyID!,
                                                                       title: noticeTitle)
                        }
                    }
                    if let noticeDetail = $0 as? NoticeDetailViewProtocol {
                        noticeDetail.presenter?.viewDidLoad(notice: notice!)
                    }
                }
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


extension AddNoticeView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        contentTextView.becomeFirstResponder()
    }
}

extension AddNoticeView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        if updatedText.count <= 200 {
            textCountLabel.text = "\(updatedText.count)/200"
        }
        return updatedText.count <= 200
    }
}
