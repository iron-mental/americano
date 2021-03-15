//
//  TempChatView.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/01.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import SocketIO
import SwiftyJSON

class ChatView: UIViewController {
    deinit {
        self.keyboardRemoveObserver()
    }
    var presenter: ChatPresenterProtocol?
    var chatTableView = UITableView()
    var chatList: [Chat] = []
    var keyboardHeight: CGFloat = 0.0
    var textFieldConstraint: NSLayoutConstraint?
    var tableViewConstraint: NSLayoutConstraint?
    var scrollToBottomButton = UIButton()
    var isEdting = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter?.viewWillDisappear()
    }
    
    func viewLoad() {
        presenter?.viewDidLoad()
        attribute()
        layout()
        self.hideKeyboardWhenTappedAround()
        self.keyboardAddObserver(showSelector: #selector(keyboardWillShow),
                                 hideSelector: #selector(keyboardWillHide))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    func attribute() {
        view.do {
            $0.backgroundColor = .appColor(.terminalBackground)
        }
        chatTableView.do {
            $0.register(ChatInputTableViewCell.self, forCellReuseIdentifier: ChatInputTableViewCell.id)
            $0.register(ChatOutputTableViewCell.self, forCellReuseIdentifier: ChatOutputTableViewCell.id)
            $0.backgroundColor = .appColor(.terminalBackground)
            $0.separatorStyle = .none
            $0.delegate = self
            $0.dataSource = self
            $0.keyboardDismissMode = .interactive
        }
        scrollToBottomButton.do {
            $0.tintColor = .white
            $0.backgroundColor = .appColor(.InputViewColor)
            $0.layer.masksToBounds  = true
            $0.addTarget(self, action: #selector(scrollToBottom), for: .touchUpInside)
            $0.setImage(UIImage(systemName: "chevron.down")?
                            .withConfiguration(UIImage.SymbolConfiguration(weight: .regular)), for: .normal)
            if !$0.constraints.isEmpty {
                $0.layer.cornerRadius = $0.constraints[0].constant / 2
            }
        }
    }
    
    func layout() {
        [chatTableView, scrollToBottomButton].forEach { view.addSubview($0) }
        
        tableViewConstraint = chatTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        chatTableView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            tableViewConstraint?.isActive = true
        }
        scrollToBottomButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.trailingAnchor.constraint(equalTo: chatTableView.trailingAnchor,
                                         constant: -Terminal.convertWidth(value: 25)).isActive = true
            $0.bottomAnchor.constraint(equalTo: chatTableView.bottomAnchor,
                                       constant: -Terminal.convertWidth(value: 10)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 40)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 40)).isActive = true
        }
    }
    
    func tableViewAddConstant() {
        
    }
    
    // MARK: @objc
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        
        let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        self.keyboardHeight = keyboardRectangle.height
        if type(of: UIApplication.getTopViewController()) == UIAlertController.self {
            print("신고중")
        }
        let isBottom = isTableViewSetBottom()
        chatTableView.setBottomInset(to: keyboardHeight)
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
        if isBottom {
            self.chatTableView.scrollToRow(at: [0, self.chatList.count], at: .bottom,
                                           animated: false)
        }
    }
    
    @objc func keyboardWillHide() {
        let isBottom = isTableViewSetBottom()
        chatTableView.bounces = false
        chatTableView.setBottomInset(to: 0.0)
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
        if isBottom {
            self.chatTableView.scrollToRow(at: [0, self.chatList.count], at: .bottom,
                                           animated: false)
        }
        chatTableView.bounces = true
    }
    
    @objc func keyboardDidHide() {
        chatTableView.setBottomInset(to: 0.0)
    }
    
    @objc func scrollToBottom() {
        self.chatTableView.scrollToRow(at: [0, chatList.count], at: .bottom,
                                       animated: true)
    }
}

extension ChatView: ChatViewProtocol {
    func showLastChat(lastChat: [Chat]) {
        chatList += lastChat
        chatTableView.reloadData()
        if let target = lastChat.firstIndex(where: { $0.message == "여기까지 읽으셨습니다." }) {
            chatTableView.scrollToRow(at: [0, target], at: .top,
                                      animated: true)
        } else {
            self.chatTableView.scrollToRow(at: [0, self.chatList.count], at: .middle,
                                           animated: true)
        }
        presenter?.viewRoadLastChat()
    }
    
    func showSocketChat(socketChat: [Chat]) {
        let isBottom = isTableViewSetBottom()
        if socketChat.count == 1 {
            self.chatList.append(socketChat.first!)
        } else {
            self.chatList += socketChat
        }
        let indexPaths = (0 ..< socketChat.count)
            .map { IndexPath(row: (chatList.count - socketChat.count) + $0, section: 0) }
        self.chatTableView.insertRows(at: indexPaths, with: .middle)
        if isBottom {
            self.chatTableView
                .scrollToRow(at: [0, chatList.count],
                             at: .bottom,
                             animated: true)
        }
    }
    
    func isTableViewSetBottom() -> Bool {
        let interval = chatTableView.contentOffset.y
            + chatTableView.visibleSize.height
            - chatTableView.contentSize.height
            - chatTableView.contentInset.bottom
        if abs(interval) < 10 {
            return true
        } else {
            return false
        }
    }
    
    func nicknameSet(nicknameList: [ChatParticipate]) {
        
    }
    
    func showMessage(message: String) {
        
    }
    
    func showLoading() {
        LoadingRainbowCat.show(caller: self)
    }
    
    func hideLoading() {
        LoadingRainbowCat.hide(caller: self)
    }
    
    func showError(message: String) {
        showToast(controller: self, message: message, seconds: 1)
    }
    
}
extension ChatView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == chatList.count {
            let outputCell = tableView
                .dequeueReusableCell(withIdentifier: ChatOutputTableViewCell.id,
                                     for: indexPath)as! ChatOutputTableViewCell
            outputCell.textInput.delegate = self
            return outputCell
        } else {
            let inputCell = tableView
                .dequeueReusableCell(withIdentifier: ChatInputTableViewCell.id,
                                     for: indexPath) as! ChatInputTableViewCell
            inputCell.setData(chat: chatList[indexPath.row])
            return inputCell
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let interval = chatTableView.contentSize.height
            - (chatTableView.contentOffset.y + chatTableView.visibleSize.height)
        if interval > 2000 {
            UIView.animate(withDuration: 0.3) {
                self.scrollToBottomButton.alpha = 10
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.scrollToBottomButton.alpha = 0
            }
        }
    }
}

extension ChatView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let inputChatMessage = textField.text else { return true }
        presenter?.emitButtonDidTap(message: inputChatMessage)
        textField.text = ""
        return true
    }
}

extension ChatView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
