//
//  CreateStudyViewController.swift
//  Terminal-iOS
//
//  Created by once on 2020/08/31.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Then


class SelectCategoryViewController: UIViewController {
    let label = UILabel()
    let textLabel = UILabel()
    let font = UIFont(name:"Apple Color Emoji" , size: 25)
    let tempButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
     
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.navigationController?.navigationBar.topItem?.title = ""
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
            $0.frame = CGRect(x: 0, y: 0, width: 90, height: 35)
            let attributedStr = NSMutableAttributedString(string: textLabel.text ?? "empty")
            attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: font, range: NSMakeRange(0, 7))
            textLabel.attributedText = attributedStr
        }
        tempButton.do {
            $0.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            $0.backgroundColor = .green
            $0.setTitle("임시버튼", for: .selected)
            $0.addTarget(self, action: #selector(gotoCreateStudy(sender:)), for: .touchUpInside)
        }
    }
    
    func layout() {
        view.addSubview(textLabel)
        view.addSubview(tempButton)
        
        textLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 22).isActive = true
        }
        tempButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        }
    }
    
    @objc func gotoCreateStudy(sender: UIButton!) {
        print("Button tapped")
        self.dismiss(animated: false, completion: nil)
    }
}
