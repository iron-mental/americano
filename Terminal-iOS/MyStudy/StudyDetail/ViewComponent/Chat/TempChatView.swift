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

struct ChatMessage  {
      var roomNumber: Int
      var userID: Int
      var nickname: String
      var message: String
      var date: String
    }

class TempChatView: UIViewController {
    var presenter: ChatPresenterProtocol?
    var chatTableView = UITableView()
    var chatArray: [ChatMessage] = [
        ChatMessage(roomNumber: 1,
                    userID: 1,
                    nickname: "강철",
                    message: "채팅이 이루어지는 모습",
                    date: "오후: 06: 16"),
        ChatMessage(roomNumber: 1,
                    userID: 1,
                    nickname: "상원",
                    message: "ubuntu font를 사용",
                    date: "오후: 08: 25"),
        ChatMessage(roomNumber: 1,
                    userID: 1,
                    nickname: "재인",
                    message: "조금 더 손을 봐야함",
                    date: "오후: 08: 26")
    ]
//    var inputTextField = UITextField()
//    var emitButton = UIButton()
//    var textLabel = UILabel()
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
//        inputTextField.do {
//            $0.textColor = .white
//            $0.layer.borderWidth = 2
//            $0.layer.borderColor = UIColor.white.cgColor
//        }
//        emitButton.do {
//            $0.setTitle("방출", for: .normal)
//            $0.addTarget(self, action: #selector(didEmitButtonClicked), for: .touchUpInside)
//        }
//        textLabel.do {
//            $0.text = ""
//            $0.textColor = .red
//            $0.layer.borderWidth = 2
//            $0.layer.borderColor = UIColor.white.cgColor
//            $0.textAlignment = .center
//        }
    }
    
    func layout() {
//        [inputTextField, emitButton, textLabel].forEach { view.addSubview($0) }
        [chatTableView].forEach { view.addSubview($0) }
        chatTableView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
//        inputTextField.do{
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
//            $0.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//            $0.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        }
//        emitButton.do {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//            $0.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 20).isActive = true
//            $0.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//            $0.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        }
//        textLabel.do {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            $0.centerXAnchor.constraint(equalTo: emitButton.centerXAnchor).isActive = true
//            $0.topAnchor.constraint(equalTo: emitButton.bottomAnchor).isActive = true
//            $0.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//            $0.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        }
    }
    
//    @objc func didEmitButtonClicked(_ sender: UIButton) {
//        inputTextField.text = ""
//        presenter?.emitButtonDidTap(message: inputTextField.text!)
//    }
}

extension TempChatView: ChatViewProtocol {
    func showMessage(message: String) {
    }
    
    
}
extension TempChatView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArray.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let inputCell = tableView.dequeueReusableCell(withIdentifier: ChatInputTableViewCell.id, for: indexPath) as! ChatInputTableViewCell
        let outputCell = tableView.dequeueReusableCell(withIdentifier: ChatOutputTableViewCell.id, for: indexPath) as! ChatOutputTableViewCell
        
        if indexPath.row == chatArray.count {
            return outputCell
        } else {
            inputCell.chatLabel.text =  "[\(chatArray[indexPath.row].date)] \(chatArray[indexPath.row].nickname) $ \(chatArray[indexPath.row].message)"
            return inputCell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}
