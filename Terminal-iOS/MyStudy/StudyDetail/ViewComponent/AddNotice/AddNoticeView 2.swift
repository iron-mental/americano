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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
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
            $0.addLeftPadding()
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
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Terminal.convertHeigt(value: 10)).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Terminal.convertHeigt(value: 10)).isActive = true
        }
        titleGuideLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: titleTextField.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Terminal.convertWidth(value: 10)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 40)).isActive = true
        }
        titleTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: isEssentialFlagSege.bottomAnchor, constant: Terminal.convertHeigt(value: 20)).isActive = true
            $0.leadingAnchor.constraint(equalTo: titleGuideLabel.trailingAnchor, constant: Terminal.convertWidth(value: 10)).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Terminal.convertWidth(value: 10)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 30)).isActive = true
        }
        contentGuideLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: Terminal.convertHeigt(value: 10)).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Terminal.convertWidth(value: 10)).isActive = true
            $0.trailingAnchor.constraint(equalTo: titleGuideLabel.trailingAnchor).isActive = true
        }
        contentTextView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: contentGuideLabel.bottomAnchor, constant: Terminal.convertHeigt(value: 10)).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Terminal.convertWidth(value: 10)).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Terminal.convertWidth(value: 10)).isActive = true
            $0.bottomAnchor.constraint(equalTo: completeButton.topAnchor, constant: Terminal.convertHeigt(value: -9)).isActive = true
        }
        bottomAnchor = completeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        completeButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            bottomAnchor?.isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 335)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 45)).isActive = true
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
        dismiss(animated: false) { [self] in
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
                ((self.parentView as! MyStudyDetailViewProtocol).VCArr[0] as! NoticeViewProtocol).viewLoad()
                (self.parentView as! MyStudyDetailViewProtocol).presenter?.addNoticeFinished(notice: noticeID, studyID: studyID!, parentView: parentView!)
            } else {
                //parentView는 당연히 NoticedetailViewProtocol을 이미 준수하는중
                (self.parentView as! NoticeDetailViewProtocol).presenter?.viewDidLoad(notice: notice!)
                ((self.parentView as! NoticeDetailViewProtocol).parentView as! NoticeViewProtocol).viewLoad()
            }
        }
    }
}


extension AddNoticeView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        contentTextView.becomeFirstResponder()
    }
}

extension AddNoticeView: UITextViewDelegate {
    
}
