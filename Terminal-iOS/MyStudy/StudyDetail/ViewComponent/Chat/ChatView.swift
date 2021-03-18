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
    var blurEffect = UIBlurEffect(style: .regular)
    lazy var visualEffectView = UIVisualEffectView(effect: blurEffect)
    let validGuideLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1.5) {
            self.visualEffectView.alpha = 0
        } completion: { _ in
            self.visualEffectView.isHidden = true
        }
    }
    
    func viewLoad() {
        presenter?.viewDidLoad()
        attribute()
        layout()
        self.keyboardAddObserver(showSelector: #selector(keyboardWillShow),
                                 hideSelector: #selector(keyboardWillHide))
    }
    
    func disconnectSocket() {
        presenter?.viewWillDisappear()
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
            $0.keyboardDismissMode = .onDrag
            $0.prefetchDataSource = self
        }
        scrollToBottomButton.do {
            $0.addTarget(self, action: #selector(scrollToBottom), for: .touchUpInside)
            if !$0.constraints.isEmpty {
                $0.layer.cornerRadius = $0.constraints[0].constant / 2
            }
            $0.setImage(UIImage(systemName: "chevron.down")?
                            .withConfiguration(UIImage.SymbolConfiguration(weight: .bold)), for: .normal)
            $0.tintColor = .appColor(.mainColor)
            $0.backgroundColor = .appColor(.InputViewColor)
            $0.layer.masksToBounds  = true
            $0.alpha = 0
        }
        validGuideLabel.do {
            $0.dynamicFont(fontSize: 15, weight: .bold)
            $0.text = "폭력적인 채팅은 자제해주세요😭"
        }
        visualEffectView.do {
            $0.bringSubviewToFront(self.view)
            $0.alpha = 1.0
        }
    }
    
    func layout() {
        [chatTableView, scrollToBottomButton, visualEffectView].forEach { view.addSubview($0) }
        visualEffectView.contentView.addSubview(validGuideLabel)
        
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
            $0.centerXAnchor.constraint(equalTo: chatTableView.centerXAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: chatTableView.bottomAnchor,
                                       constant: -Terminal.convertWidth(value: 10)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 60)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 60)).isActive = true
        }
        validGuideLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
        visualEffectView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        }
    }
    
    // MARK: 키보드 올라갈 때
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        self.keyboardHeight = keyboardRectangle.height
        var fromEmoticon = false
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows[0]
            let bottomPadding = window.safeAreaInsets.bottom
            if let constant = tableViewConstraint?.constant {
                if constant < (-keyboardHeight + bottomPadding) {
                    fromEmoticon = true
                }
            }
            tableViewConstraint?.constant = -keyboardHeight + bottomPadding
        }
        
        UIView.animate(withDuration: fromEmoticon ? 0.1 : 1) {
            self.view.layoutIfNeeded()
        }
        self.chatTableView.scrollToRow(at: [0, self.chatList.count], at: .bottom,
                                       animated: false)
    }
    
    // MARK: 키보드 내려갈 때
    @objc func keyboardWillHide() {
        let isBottom = isTableViewSetBottom()
        chatTableView.bounces = false
        tableViewConstraint?.constant = 0
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
        if isBottom {
            self.chatTableView.scrollToRow(at: [0, self.chatList.count], at: .bottom,
                                           animated: false)
        } 
        chatTableView.bounces = true
    }
    
    // MARK: scrollToBottom 액션
    @objc func scrollToBottom() {
        scrollToBottomButton.alpha = 0
        self.chatTableView.scrollToRow(at: [0, chatList.count], at: .bottom,
                                       animated: true)
    }
    
    // MARK: sendButton 액션
    @objc func sendButtonDidTap(_ sender: UIButton) {
        if let cell = sender.superview?.superview as? ChatOutputTableViewCell {
            guard let inputChatMessage = cell.textInput.text else { return }
            presenter?.emitButtonDidTap(message: inputChatMessage)
            cell.textInput.text = ""
            sender.isEnabled = false
            sender.tintColor = .lightGray
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                sender.isEnabled = true
                sender.tintColor = .appColor(.mainColor)
            }
        }
    }
}

extension ChatView: ChatViewProtocol {
    // MARK: 로컬챗 + 리모트챗 처리 (최초 1회 실행)
    func showLastChat(lastChat: [Chat]) {
        chatList = lastChat
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
    
    // MARK: 소켓으로 들어온 챗 처리
    func showSocketChat(socketChat: [Chat], reloadIndex: Int?) {
        UIView.setAnimationsEnabled(false)
        let isBottom = isTableViewSetBottom()
        let diffrence = abs(socketChat.count - chatList.count)
        chatList = socketChat
        let indexPaths = (0 ..< diffrence)
            .map { IndexPath(row: (chatList.count - diffrence) + $0, section: 0) }
        self.chatTableView.insertRows(at: indexPaths, with: .middle)
        if isBottom {
            self.chatTableView
                .scrollToRow(at: [0, chatList.count],
                             at: .bottom,
                             animated: false)
        }
        if let index = reloadIndex {
            let indexPaths = (0 ..< index)
                .map { IndexPath(row: (chatList.count - index) + $0, section: 0) }
            self.chatTableView.beginUpdates()
            self.chatTableView.reloadRows(at: indexPaths, with: .fade)
            self.chatTableView.endUpdates()
        }
        UIView.setAnimationsEnabled(true)
    }
    
    // MARK: 테이블뷰가 바닥에 있는 지 확인
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
    
    // MARK: 페이징챗 처리
    func showPagingChat(pagingChat: [Chat]) {
        let diffrence = pagingChat.count - chatList.count
        chatList = pagingChat
        if diffrence != 0 {
            chatTableView.beginUpdates()
            let indexPaths = (0 ..< diffrence)
                .map { IndexPath(row: $0, section: 0) }
            chatTableView.insertRows(at: indexPaths, with: .none)
            chatTableView.endUpdates()
        }
    }
    
    // MARK: 전송 실패한 메세지 처리
    func emitFailed(uuid: String) {
        if let index = chatList.firstIndex(where: { $0.uuid == uuid }) {
            chatList[index].isTemp = false
            chatTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }
    }
    
    func showLoading() {
        LoadingRainbowCat.show(caller: self)
    }
    
    func hideLoading() {
        LoadingRainbowCat.hide(caller: self)
    }
    
    func showError(message: String) {
        visualEffectView.isHidden = false
        visualEffectView.alpha = 1
        validGuideLabel.text = "연결이 불안정합니다. 잠시 후에 다시 시도해 주세요"
        showToast(controller: self, message: message, seconds: 1)
    }
    
}

extension ChatView: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == chatList.count {
            let outputCell = tableView
                .dequeueReusableCell(withIdentifier: ChatOutputTableViewCell.id,
                                     for: indexPath)as! ChatOutputTableViewCell
            outputCell.sendButton.addTarget(self,
                                            action: #selector(sendButtonDidTap(_: )),
                                            for: .touchUpInside)
            return outputCell
        } else {
            let inputCell = tableView
                .dequeueReusableCell(withIdentifier: ChatInputTableViewCell.id,
                                     for: indexPath) as! ChatInputTableViewCell
            inputCell.setData(chat: chatList[indexPath.row])
            return inputCell
        }
    }
    
    // MARK: 스크롤 도움 버튼 액션
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let interval = chatTableView.contentSize.height
            - (chatTableView.contentOffset.y + chatTableView.visibleSize.height)
        if interval > 1700 {
            UIView.animate(withDuration: 0.3) {
                self.scrollToBottomButton.alpha = 10
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.scrollToBottomButton.alpha = 0
            }
        }
    }
    
    // MARK: 페이지네이션
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            print(indexPath.row)
        }
        for indexPath in indexPaths where indexPath.row < 15 {
            presenter?.chatPaging()
        }
    }
}
