//
//  CreateStudyViewController.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/08.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol testDelegate {
    func setData(data: String)
}

class CreateStudyViewController: UIViewController {
    let tempTextLabel = UILabel()
    let textField = UITextField()
    let button = UIButton()
    var delegate: testDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        view.do {
            $0.backgroundColor = .green
        }
        tempTextLabel.do {
            $0.frame = CGRect(x: 0, y: 0, width: 0, height: 35)
            $0.backgroundColor = .red
        }
        textField.do {
            $0.frame = CGRect(x: 0, y: 0, width: 0, height: 40)
            $0.backgroundColor = .blue
        }
        button.do {
            $0.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            $0.backgroundColor = .systemPink
            $0.addTarget(self, action: #selector(backToPreView), for: .touchUpInside)
        }
    }
    
    func layout() {
        view.addSubview(tempTextLabel)
        view.addSubview(textField)
        view.addSubview(button)
        
        tempTextLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        }
        textField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor,constant: -150).isActive = true
            $0.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -150).isActive = true
        }
        button.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -75).isActive = true
            
        }
    }
    @objc func backToPreView() {
        navigationController?.popViewController(animated: true)
        if let text = textField.text {
            delegate?.setData(data: text)
        }
    }
}
