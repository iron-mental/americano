//
//  TerminalAlertUIView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/05.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class AlertBaseUIView: UIView {
    var redButton = UIButton()
    var yellowButton = UIButton()
    var greenButton = UIButton()
    var topBar = UIView()
    var bottomBar = UIView()
    var dismissButton = UIButton()
    var completeButton = UIButton()
    
    init() {
        super.init(frame: CGRect.zero)
        layout()
        attribute()
    }
    
    func attribute() {
        self.do {
            $0.backgroundColor = UIColor.appColor(.alertBackgroundColor)
            $0.layer.cornerRadius = 5
            $0.layer.masksToBounds = true
            $0.alpha = 1
        }
        topBar.do {
            $0.backgroundColor = UIColor.appColor(.alertTopBarColor)
            $0.layer.cornerRadius = 5
            $0.layer.masksToBounds = true
        }
        bottomBar.do {
            $0.backgroundColor = UIColor.appColor(.alertBackgroundColor)
        }
        redButton.do {
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 5
            $0.backgroundColor = UIColor.appColor(.redButtonColor)
            $0.setTitle("", for: .normal)
        }
        yellowButton.do {
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 5
            $0.backgroundColor = UIColor.appColor(.yellowButtonColor)
            $0.setTitle("", for: .normal)
        }
        greenButton.do {
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 5
            $0.backgroundColor = UIColor.appColor(.greenButtonColor)
            $0.setTitle("", for: .normal)
        }
        dismissButton.do {
            $0.setTitle("취소", for: .normal)
            $0.setTitleColor(UIColor.appColor(.alertTextcolor), for: .normal)
            $0.backgroundColor = UIColor.appColor(.alertBackgroundColor)
            $0.titleLabel?.dynamicFont(fontSize: 14, weight: .regular)
        }
        completeButton.do {
            $0.setTitle("확인", for: .normal)
            $0.setTitleColor(UIColor.appColor(.alertTextcolor), for: .normal)
            $0.backgroundColor = UIColor.appColor(.alertBackgroundColor)
            $0.titleLabel?.dynamicFont(fontSize: 14, weight: .regular)
        }
    }
    
    func layout() {
        [ topBar, bottomBar ].forEach { addSubview($0) }
        [ redButton, yellowButton, greenButton ].forEach { topBar.addSubview($0) }
        [ dismissButton, completeButton ].forEach { bottomBar.addSubview($0) }
        
        topBar.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 20).isActive = true
        }
        bottomBar.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: -3).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
        redButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: topBar.centerYAnchor, constant: -2).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: topBar.leadingAnchor, constant: 13).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 10).isActive = true
        }
        yellowButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: redButton.centerYAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: redButton.trailingAnchor, constant: 13).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 10).isActive = true
        }
        greenButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: redButton.centerYAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: yellowButton.trailingAnchor, constant: 13).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 10).isActive = true
        }
        dismissButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 30)).isActive = true
            $0.bottomAnchor.constraint(equalTo: bottomBar.bottomAnchor, constant: -10).isActive = true
            $0.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: bottomBar.centerXAnchor).isActive = true
        }
        completeButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 30)).isActive = true
            $0.bottomAnchor.constraint(equalTo: bottomBar.bottomAnchor, constant: -10).isActive = true
            $0.leadingAnchor.constraint(equalTo: bottomBar.centerXAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor).isActive = true
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
