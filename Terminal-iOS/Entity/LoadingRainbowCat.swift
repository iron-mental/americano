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
    //    var animationView = AnimationView(name:"12670-flying-airplane")
    private var backgroundView: UIView?
    private var popupView: AnimationView?
    
    class func show() {
        let backgroundView = UIView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        let popupView = AnimationView(name:"14476-rainbow-cat-remix")
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(backgroundView)
            window.addSubview(popupView)
            popupView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
            backgroundView.frame = CGRect(x: 0, y: 0, width: window.frame.maxX, height: window.frame.maxY)
            backgroundView.backgroundColor = .black
            backgroundView.alpha = 0.6
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
        
        
    }
    
    class func hide(completion: @escaping () -> Void) {
        if let popupView = sharedInstance.popupView,
           let backgroundView = sharedInstance.backgroundView {
            popupView.stop()
            backgroundView.removeFromSuperview()
            popupView.removeFromSuperview()
        }
        completion()
        
    }
}
