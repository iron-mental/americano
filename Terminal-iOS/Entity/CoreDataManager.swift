//
//  CoreDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import CoreData
import UIKit


class CoreDataManager {
    static let shared: CoreDataManager = CoreDataManager()
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let modelName: String = ""
    

}
