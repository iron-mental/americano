//
//  SNSInputUITextField.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/23.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SNSInputUITextField: UITextField {
    deinit {
        self.removeTarget(self, action: #selector(self.editingChanged(_:)), for: .editingChanged)
    }
    
    
    private var workItem: DispatchWorkItem?
    private var delay: Double = 0
    private var callback: ((String?) -> Void)? = nil
    
    func debounce(delay: Double, callback: @escaping ((String?) -> Void)) {
        self.delay = delay
        self.callback = callback
        DispatchQueue.main.async {
            self.callback?(self.text)
        }
        self.addTarget(self, action: #selector(self.editingChanged(_:)), for: .editingChanged)
    }
    
    @objc private func editingChanged(_ sender: UITextField) {
        self.workItem?.cancel()
        
        let workItem = DispatchWorkItem(block: { [weak self] in
            self?.callback?(sender.text)
        })
        
        self.workItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + self.delay, execute: workItem)
    }
}
