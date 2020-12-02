//
//  TestViewController.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/03.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Alamofire

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let url = API.BASE_URL+"/user/1"
        print("히바", TerminalRouter.userGet(path: "1"))
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.userGet(path: "1"))
            .validate()
            .responseJSON { response in
                 debugPrint(response)
            }
    }
}
