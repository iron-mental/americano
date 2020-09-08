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
    let tempView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textLabelAnimation()
    }
    
    func attribute() {
        view.do {
            $0.backgroundColor = .white
        }
        label.do {
            $0.text = ""
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
        tempView.do {
            $0.image = #imageLiteral(resourceName: "categoryimage")
            $0.contentMode = .scaleAspectFit
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "<<<<", style: .plain, target: self, action: #selector(backTapped(sender:)))
    }
    
    func layout() {
        view.addSubview(textLabel)
        view.addSubview(tempView)
        
        textLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 500).isActive = true
        }
        tempView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -30).isActive = true
            
        }
    }
    
    
    func textLabelAnimation() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .transitionCurlUp, animations: {
            self.textLabel.transform = self.label.transform.translatedBy(x: -490, y: 0)
        }) { _ in
            UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCurlUp, animations: {
                self.textLabel.transform = self.label.transform.translatedBy(x: -480, y: 0)
            }) { _ in
                UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCurlUp, animations: {
                    self.textLabel.transform = self.label.transform.translatedBy(x: -485, y: 0)
                })
            }
        }
    }
    
    @objc func gotoCreateStudy(sender: UIButton!) {
        let createStudyViewController = CreateStudyViewController()
        createStudyViewController.delegate = self
        navigationController?.pushViewController(createStudyViewController, animated: true)
    }
    @objc func backTapped(sender: UIBarButtonItem) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .transitionCurlUp, animations: {
            self.textLabel.transform = self.textLabel.transform.translatedBy(x: 500, y: 0)
        }) { _ in
            UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCurlUp, animations: {
                self.tempView.transform = self.tempView.transform.translatedBy(x: 0, y: -60)
            },completion: { _ in
               self.navigationController?.popViewController(animated: false)
            })
        }
    }
}

extension SelectCategoryViewController: testDelegate {
    func setData(data: String) {
    }
}
