//
//  CreateStudyViewController.swift
//  Terminal-iOS
//
//  Created by once on 2020/08/31.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Then


class CreateStudyViewController: UIViewController {
    let label = UILabel()
    let textLabel = UILabel()
    let font = UIFont(name:"Apple Color Emoji" , size: 16)
    
    override func viewDidLoad() {
        super.viewDidLoad()
            attribute()
            layout()
        }

    func attribute() {
        view.do {
            $0.backgroundColor = .white
        }
        label.do {
            $0.text = "스터디 만들기"
            $0.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        }
        navigationItem.do {
            $0.titleView = label
        }
        textLabel.do {
            $0.text = "카테고리 선택"
            let attributedStr = NSMutableAttributedString(string: textLabel.text ?? "empty")
            attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: font, range: NSMakeRange(0, 7))
            textLabel.attributedText = attributedStr
        }
    }
    
    func layout() {
        view.addSubview(textLabel)
        
        textLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.frame = CGRect(x: 0, y: 0, width: 90, height: 35)
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 22).isActive = true
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = ""
    }
}
