//
//  UIViewController+Ext.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/13.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

extension UIViewController {
    func showToast(controller: UIViewController,
                   message: String,
                   seconds: Double,
                   completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.view.backgroundColor = .appColor(.terminalBackground)
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 20
        
        let titleFont = [NSAttributedString.Key.font: UIFont(name: "NotoSansKR-Medium", size: 15)]
        let titleAttrString = NSMutableAttributedString(string: message, attributes: titleFont as [NSAttributedString.Key: Any])
        
        alert.setValue(titleAttrString, forKey: "attributedTitle")
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popoverController = alert.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
                self.present(alert, animated: true, completion: nil)
                
            }
        } else {
            controller.present(alert, animated: true)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true) {
                CATransaction.setCompletionBlock(completion)
            }
        }
    }
    
    func keyboardAddObserver(showSelector: Selector? = nil,
                             hideSelector: Selector? = nil) {
        if let showSelector = showSelector {
            NotificationCenter.default.addObserver(self, selector: showSelector, name: UIResponder.keyboardWillShowNotification, object: nil)
        }
        
        if let hideSelector = hideSelector {
            NotificationCenter.default.addObserver(self, selector: hideSelector, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    }
    
    func keyboardRemoveObserver() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
