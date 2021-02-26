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
    
    class func show(caller: UIViewController?) {
        guard let topViewController =  UIApplication.getTopViewController() else { return }
        guard let callerViewController = caller else { return }
        if type(of: topViewController) == type(of: callerViewController) {
            print("들어오는데 성공한 애는 바로", caller)
            let backgroundView = UIView()
            let popupView = AnimationView(name: "14476-rainbow-cat-remix")
            if let window = UIApplication.shared.windows.first {
                window.addSubview(backgroundView)
                window.addSubview(popupView)
                window.backgroundColor = UIColor.appColor(.terminalBackground)
                popupView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
                backgroundView.frame = CGRect(x: 0, y: 0, width: window.frame.maxX, height: window.frame.maxY)
                backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
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
                hide(caller: UIApplication.getTopViewController())
            }
        }
    }
    
    class func hide(caller: UIViewController?, completion: (() -> Void)? = nil) {
        guard let topViewController =  UIApplication.getTopViewController() else { return }
        guard let callerViewController = caller else { return }
        if type(of: topViewController) == type(of: callerViewController) {
            print("문 닫은애는 바로", caller)
            if let popupView = sharedInstance.popupView,
               let backgroundView = sharedInstance.backgroundView {
                popupView.stop()
                backgroundView.removeFromSuperview()
                popupView.removeFromSuperview()
            }
            completion?()
        }
    }
}
