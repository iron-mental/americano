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
            Category(image: UIImage(named: "ai")!,name: "set"),
            Category(image: UIImage(named: "android")!,name: "set"),
            Category(image: UIImage(named: "backend")!,name: "set"),
            Category(image: UIImage(named: "blockchain")!,name: "set"),
            Category(image: UIImage(named: "dataengineer")!,name: "set"),
            Category(image: UIImage(named: "desktop")!,name: "set"),
            Category(image: UIImage(named: "devops")!,name: "set"),
            Category(image: UIImage(named: "frontend")!,name: "set"),
            Category(image: UIImage(named: "game")!,name: "set"),
            Category(image: UIImage(named: "ios")!,name: "set"),
            Category(image: UIImage(named: "embeded")!,name: "set"),
            Category(image: UIImage(named: "iot")!,name: "set"),
            Category(image: UIImage(named: "secure")!,name: "set")   
        ]
        return arr
    }
    
}
