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
        return [Study(id: 0, title: "", introduce: "", image: "", sigungu: "", leaderImage: "", createdAt: "", members: 0, isMember: true, isPaging: nil)]
    }
    func saveStudylist(studyList: [Study]) {
    }
}
