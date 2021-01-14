//
//  UIViewController+Ext.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/13.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

extension UIViewController {
    func showToast(controller: UIViewController, message: String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.view.backgroundColor = .appColor(.terminalBackground)
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 20
        
        let titleFont = [NSAttributedString.Key.font: UIFont(name: "NotoSansKR-Medium", size: 15)]
        let titleAttrString = NSMutableAttributedString(string: message, attributes: titleFont)

        alert.setValue(titleAttrString, forKey:"attributedTitle")
        
        controller.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    func keyboardAddObserver(with controller: UIViewController,
                             showSelector: Selector,
                             hideSelector: Selector) {
        NotificationCenter.default.addObserver(controller, selector: showSelector, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(controller, selector: hideSelector, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func keyboardRmoveObserver(with controller: UIViewController) {
        NotificationCenter.default.removeObserver(controller,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(controller,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
}
