//
//  StudyCategoryLocalDataManager.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class StudyCategoryLocalDataManager: StudyCategoryLocalDataManagerInputProtocol {
    func retrieveStudyCategory() -> [Category] {
        let arr = [
            Category(image: UIImage(named: "ai")!,name: "ios"),
            Category(image: UIImage(named: "android")!,name: "android"),
            Category(image: UIImage(named: "backend")!,name: "ios"),
            Category(image: UIImage(named: "blockchain")!,name: "ios"),
            Category(image: UIImage(named: "dataengineer")!,name: "ios"),
            Category(image: UIImage(named: "desktop")!,name: "ios"),
            Category(image: UIImage(named: "devops")!,name: "ios"),
            Category(image: UIImage(named: "frontend")!,name: "ios"),
            Category(image: UIImage(named: "game")!,name: "ios"),
            Category(image: UIImage(named: "ios")!,name: "ios"),
            Category(image: UIImage(named: "embeded")!,name: "ios"),
            Category(image: UIImage(named: "iot")!,name: "ios"),
            Category(image: UIImage(named: "secure")!,name: "ios")
        ]
        return arr
    }
    
}
