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

class TempChatView: UIViewController {
    var receiveLabel = UILabel()
    var textField = UITextField()
    var emitButton = UIButton()
    
    lazy var manager = SocketManager(socketURL: URL(string: "http://3.35.154.27:3000/v1/chat")!, config: [.log(false), .compress, .connectParams(["token": Terminal.tempToken, "room":10])])
    var chatSocket: SocketIOClient!
    
    func layout() {
        [receiveLabel, textField, emitButton].forEach { view.addSubview($0) }
        
        receiveLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 70).isActive = true
        }
        textField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: receiveLabel.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 70).isActive = true
        }
        emitButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 70).isActive = true
        }
    }
    
    func attribute() {
        receiveLabel.do {
            $0.backgroundColor = .white
            $0.textColor = .black
        }
        textField.do {
            $0.backgroundColor = .red
            $0.textColor = .black
        }
        emitButton.do {
            $0.addTarget(self, action: #selector(didEmitButtonClickec), for: .touchUpInside)
            $0.backgroundColor = .white
            $0.setImage(#imageLiteral(resourceName: "marker"), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatSocket = manager.socket(forNamespace: "/android")
        
        
        chatSocket.connect()
        
        
        
        
        
        attribute()
        chatSocket.on("message") { [self] (array, ack) in

            JSON(array).array?.forEach {
                receiveLabel.text = $0.string!
                print("이거 제깍제깍오면 내잘못",$0)
            }

        }
        
        layout()
        
        chatSocket.emit("chat", textField.text!)
    }
    
    
    @objc func didEmitButtonClickec(_ sender: UIButton) {
        chatSocket.emit("chat", textField.text!)
    }
}
