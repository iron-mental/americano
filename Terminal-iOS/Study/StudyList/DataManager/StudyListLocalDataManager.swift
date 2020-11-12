//
//  StudyListLocalDataManager.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class StudyListLocalDataManager: StudyListLocalDataManagerInputProtocol {
    func retrieveStudyList() throws -> [Study] {
        return [Study(title: "", subTitle: "", location: "", date: "", managerImage: "", mainImage: "")]
    }
}
