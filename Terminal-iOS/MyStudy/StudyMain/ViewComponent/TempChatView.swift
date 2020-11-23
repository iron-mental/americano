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
    var chatTableView = UITableView()
    var chatArray: [ChatMessage] = [
        ChatMessage(roomNumber: 1,
                    userID: 1,
                    nickname: "강철",
                    message: "이거되냐",
                    date: "오후 06시 16분"),
        ChatMessage(roomNumber: 1,
                    userID: 1,
                    nickname: "강철",
                    message: "이거되냐",
                    date: "오후 06시 16분"),
//        ChatMessage(roomNumber: 1,
//                    userID: 1,
//                    nickname: "강철",
//                    message: "이거되냐",
//                    date: "오후 06시 16분"),
//        ChatMessage(roomNumber: 1,
//                    userID: 1,
//                    nickname: "강철",
//                    message: "이거되냐",
//                    date: "오후 06시 16분")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        chatTableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = .black
            $0.register(ChatTableViewCell.self, forCellReuseIdentifier: ChatTableViewCell.id)
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
    
    @objc func didEmitButtonClicked(_ sender: UIButton) {
//        프레젠터로 값 넘겨줘야겠네
    }
}
extension TempChatView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArray.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.id, for: indexPath) as! ChatTableViewCell
        
        
        
        if indexPath.row == chatArray.count {
//            cell.chatLabel.isHidden = true
//            cell.textInput.isHidden = false
//            cell.textInput.placeholder = "_"
            cell.chatLabel.text = "[오후: 08: 13] 갓우석 $ 1시에 뵐게요~"
        } else {
            print(chatArray[indexPath.row].message)
//            cell.chatLabel.text = chatArray[indexPath.row].message
            cell.chatLabel.text =  "[오후: 08: 12] 용제리 $ 오늘 모임 몇시까지 인지 아시는 분 계신가요?"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}
