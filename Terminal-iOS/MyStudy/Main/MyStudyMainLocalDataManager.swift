//
//  MyStudyMainLocalDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import CoreData

class MyStudyMainLocalDataManager: MyStudyMainLocalDataManagerProtocol {
    let context = ((UIApplication.shared.delegate) as! AppDelegate).persistentContainer.viewContext
}
