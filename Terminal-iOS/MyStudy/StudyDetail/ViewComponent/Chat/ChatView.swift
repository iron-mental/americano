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
    var presenter: ChatPresenterProtocol?
    var chatTableView = UITableView()
    var chatList: [Chat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        attribute()
        layout()
    }
    override func viewWillDisappear(_ animated: Bool) {
        presenter?.viewWillDisappear()
    }
    
    func attribute() {
        chatTableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = .black
            $0.register(ChatInputTableViewCell.self, forCellReuseIdentifier: ChatInputTableViewCell.id)
            $0.register(ChatOutputTableViewCell.self, forCellReuseIdentifier: ChatOutputTableViewCell.id)
            $0.separatorStyle = .none
        }
    }
    
    func layout() {
        [chatTableView].forEach { view.addSubview($0) }
        chatTableView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
}

extension ChatView: ChatViewProtocol {
    func showLastChat(lastChat: [Chat]) {
        chatList += lastChat
        chatTableView.reloadData()
        presenter?.viewRoadLastChat()
    }
    func showSocketChat(socketChat: [Chat]) {
        chatList += socketChat
        chatTableView.reloadData()
    }
    
    func showMessage(message: String) {
        
    }
}
extension ChatView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == chatList.count {
            let outputCell = tableView.dequeueReusableCell(withIdentifier: ChatOutputTableViewCell.id, for: indexPath) as! ChatOutputTableViewCell
            outputCell.textInput.delegate = self
            return outputCell
        } else {
            let inputCell = tableView.dequeueReusableCell(withIdentifier: ChatInputTableViewCell.id, for: indexPath) as! ChatInputTableViewCell
            inputCell.chatLabel.text =  "[\(chatList[indexPath.row].date)] \(chatList[indexPath.row].nickname) $ \(chatList[indexPath.row].message)"
            return inputCell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}

extension ChatView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let inputChatMessage = textField.text else { return true }
        presenter?.emitButtonDidTap(message: inputChatMessage)
        
        return true
    }
}
