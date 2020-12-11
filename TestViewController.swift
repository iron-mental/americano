//
//  TestViewController.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/03.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper
import SwiftyJSON

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        NotificationCenter.default.addObserver(self, selector: #selector(active), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc func active() {
        handleNotifData()
    }
    
    func handleNotifData() {
            let pref = UserDefaults.init(suiteName: "group.id.gits.notifserviceextension")
            let notifData = pref?.object(forKey: "NOTIF_DATA") as? NSDictionary
            let aps = notifData?["aps"] as? NSDictionary
            let alert = aps?["alert"] as? NSDictionary
            let body = alert?["body"] as? String
            
        }
}
