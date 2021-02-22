//
//  LoadingRainbowCat.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/02.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Lottie

class LoadingRainbowCat: NSObject {
    private static let sharedInstance = LoadingRainbowCat()
    private var backgroundView: UIView?
    private var popupView: AnimationView?
    
    class func show() {
        let backgroundView = UIView()
        let popupView = AnimationView(name: "14476-rainbow-cat-remix")
        if let window = UIApplication.shared.windows.first {
            window.addSubview(backgroundView)
            window.addSubview(popupView)
            window.backgroundColor = UIColor.appColor(.terminalBackground)
            popupView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
            backgroundView.frame = CGRect(x: 0, y: 0, width: window.frame.maxX, height: window.frame.maxY)
            backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
            popupView.center = window.center
            
            sharedInstance.backgroundView?.removeFromSuperview()
            sharedInstance.popupView?.removeFromSuperview()
            sharedInstance.backgroundView = backgroundView
            sharedInstance.popupView = popupView
        }
        popupView.contentMode = .scaleAspectFit
        popupView.play()
        popupView.loopMode = .loop
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            hide()
        }
    }
    
    class func hide(completion: (() -> Void)? = nil) {
        
        if let popupView = sharedInstance.popupView,
           let backgroundView = sharedInstance.backgroundView {
            popupView.stop()
            backgroundView.removeFromSuperview()
            popupView.removeFromSuperview()
        }
        completion?()
    }
}
