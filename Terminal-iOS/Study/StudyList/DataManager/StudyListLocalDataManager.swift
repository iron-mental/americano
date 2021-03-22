//
//  StudyListLocalDataManager.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import CoreData

class StudyListLocalDataManager: StudyListLocalDataManagerInputProtocol {
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    func retrieveStudyList() throws -> [Study] {
        return [Study(id: 0, title: "", introduce: "", image: "", sigungu: "", leaderImage: "", createdAt: 0, memberCount: 0, distance: 1, isMember: true, isPaging: false)]
    }
    
    func saveStudylist(studyList: [Study]) {
        
    }
}
