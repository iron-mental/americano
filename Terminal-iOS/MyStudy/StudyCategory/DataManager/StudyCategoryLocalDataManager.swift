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
            Category(name: UIImage(named: "swift")!), Category(name: UIImage(named: "android")!), Category(name: UIImage(named: "tensorflow")!), Category(name: UIImage(named: "node")!), Category(name: UIImage(named: "frontend")!), Category(name: UIImage(named: "android")!), Category(name: UIImage(named: "node")!), Category(name: UIImage(named: "jpark")!), Category(name: UIImage(named: "jpark")!), Category(name: UIImage(named: "jpark")!), Category(name: UIImage(named: "jpark")!), Category(name: UIImage(named: "jpark")!)
        ]
        return arr
    }
    
}
