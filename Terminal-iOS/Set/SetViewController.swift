//
//  SetViewController.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/08/31.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SetViewController: UIViewController {
    
    let frameView = UIView()
    let profile = UIImageView(frame: CGRect(x: 0, y: 0,
                                            width: UIScreen.main.bounds.height * 0.1,
                                            height: UIScreen.main.bounds.height * 0.1))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.terminalBackground)
        attribute()
        layout()
    }
    
    func attribute() {
        profile.do {
            $0.contentMode = .scaleAspectFill
            $0.image = #imageLiteral(resourceName: "leehi")
            $0.layer.cornerRadius = $0.frame.size.width/2
            $0.clipsToBounds = true
        }
    }
    
    func layout() {
        view.addSubview(frameView)
        frameView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.126).isActive = true
        }
        
        view.addSubview(profile)
        view.addSubview(name)
        
        profile.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: frameView.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
            $0.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.1).isActive = true
            $0.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.1).isActive = true
        }
        
    }
}
